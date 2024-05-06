//
//  HomeViewModel.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/28/24.
//

import Combine
import Foundation
import PDFKit

final class HomeViewModel: ObservableObject {
    
    enum Action {
        case viewAppear
        case makeNewBook(URL?)
        case goToPDF(Book)
    }
    
    @Published var books = [Book]()
    @Published var phase: Phase = .notRequested
    
    private var container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .viewAppear:
            container.services.bookService.getBooks()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Failed to fetch Books: \(error)")
                    }
                } receiveValue: { [weak self] books in
                    self?.books = books
                }
                .store(in: &cancellables)

        case .makeNewBook(let url):
            guard let url = url else { return }
            if url.startAccessingSecurityScopedResource() {
                
                defer { url.stopAccessingSecurityScopedResource() }
                
                do {
                    let pdfData: Data = try Data(contentsOf: url)
                    let bookId = UUID().uuidString
                    let title = url.lastPathComponent
                    
                    // MARK: - PDF -> ImageData로 변환
                    switch pdfData.convertPDFToImageDatas() {
                    case .success(let dataDict):
                        
                        // MARK: - ImageData를 서버에 업로드
                        let uploadPublishers = dataDict.map { pageNum, data in
                            Future<(Int, URL), ServiceError> { [weak self] promise in
                                guard let self = self else { return }
                                self.container.services.uploadService.uploadPDFData(source: .pdfData(bookId: bookId), data: data)
                                    .sink (receiveCompletion: { completion in
                                        switch completion {
                                        case .finished:
                                            break
                                        case .failure(let error):
                                            promise(.failure(.error(error)))
                                        }
                                    }, receiveValue: { url in
                                        promise(.success((pageNum, url)))
                                    })
                                    .store(in: &self.cancellables)
                            }
                        }
                        
                        // MARK: - 서버에 업로드 후 URL을 받아서 새로운 Book으로 변환
                        Publishers.Sequence(sequence: uploadPublishers)
                            .flatMap(maxPublishers: .max(dataDict.count)) { $0 }
                            .collect()
                            .map { urlDict -> Book in
                                // MARK: - page 순서에 맞춰 정렬한 다음 url을 String으로 변환해서 배열로 만듬
                                let urlArr = urlDict.sorted { $0.0 < $1.0 }.map { $0.1.absoluteString }
                                let newBook = Book(id: bookId,
                                                   title: title,
                                                   pdfImageURLs: urlArr,
                                                   progress: 0,
                                                   curPage: 1,
                                                   maxPage: 1,
                                                   totalPage: urlDict.count)
                                return newBook
                            }
                            .sink(receiveCompletion: { [weak self] completion in
                                guard let self = self else { return }
                                switch completion {
                                case .finished:
                                    break
                                case .failure(let error):
                                    print("Failed to convert Book Model: \(error)")
                                    self.phase = .fail
                                }
                            
                            // MARK: - 변환한 Book을 Books 및 서버에 업로드
                            }, receiveValue: { [weak self] newBook in
                                guard let self = self else { return }
                                self.books.append(newBook)
                                self.container.services.bookService.addBook(newBook, bookId: bookId)
                                    .sink(receiveCompletion: { completion in
                                        switch completion {
                                        case .finished:
                                            break
                                        case .failure(let error):
                                            print("Failed to upload Book Model: \(error)")
                                            self.phase = .fail
                                        }
                                    }, receiveValue: { _ in
                                        self.phase = .success
                                    })
                                    .store(in: &self.cancellables)
                            })
                            .store(in: &cancellables)
                        
                    case .failure(let error):
                        print("Failed to convert PDF data: \(error)")
                    }
                } catch {
                    print("Failed to load PDF data: \(error)")
                }
            }
            
        case .goToPDF(let book):
            container.navigationRouter.push(to: .pdf(book: book))
        }
    }
}
