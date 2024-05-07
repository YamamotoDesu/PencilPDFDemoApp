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
        case makeNewBook(URL?)
        case goToPDF(Book)
    }
    
    @Published var books = [Book]()
    @Published var phase: Phase = .notRequested {
        didSet {
            isLoading = phase == .loading ? true : false
        }
    }
    @Published var isLoading: Bool = false

    private var container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
        
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
    }
    
    func send(action: Action) {
        switch action {
        case .makeNewBook(let url):
            guard let url = url else { return }
            
            if url.startAccessingSecurityScopedResource() {
                defer { url.stopAccessingSecurityScopedResource() }
                
                do {
                    let pdfData: Data = try Data(contentsOf: url)
                    let bookId = UUID().uuidString
                    let title = url.lastPathComponent
                    self.convertAndUploadPDF(pdfData, bookId: bookId, title: title)
                } catch {
                    print("Failed to load PDF data: \(error)")
                }
            }
            
        case .goToPDF(let book):
            container.navigationRouter.push(to: .pdf(book: book))
        }
    }
    
    private func convertAndUploadPDF(_ pdfData: Data, bookId: String, title: String) {
        let dispatchGroup = DispatchGroup() // Dispatch Group 생성
        var urlDict = [Int: URL]()
        
        // MARK: - PDF -> ImageData로 변환
        switch pdfData.convertPDFToImageDatas() {
        case .success(let dataDict):
            
            for (pageNum, data) in dataDict {
                dispatchGroup.enter() // Dispatch Group에 작업 추가
                
                // MARK: - ImageData를 서버에 업로드
                container.services.uploadService.uploadPDFData(source: .pdfData(bookId: bookId), data: data)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("upload: \(pageNum)")
                        case .failure(let error):
                            print("Failed to upload image for page \(pageNum): \(error)")
                        }
                        dispatchGroup.leave() // 작업 완료 후 Dispatch Group에서 제거
                    }, receiveValue: { url in
                        urlDict[pageNum] = url
                    })
                    .store(in: &cancellables)
            }
            
            // MARK: - 병렬로 Firebase upload 되는 것을 기다렸다가 모두 완료되면 실행
            dispatchGroup.notify(queue: .global()) {
                let urlStringArr = urlDict.sorted { $0.0 < $1.0 }.map { $0.1.absoluteString }
                let newBook = Book(id: bookId,
                                   title: title,
                                   pdfImageURLs: urlStringArr,
                                   progress: 0,
                                   curPage: 1,
                                   maxPage: 1,
                                   totalPage: urlDict.count)
                
                // MARK: - Book upload가 완료되면 main에서 수신해서 @Published property에 반영
                self.container.services.bookService.addBook(newBook, bookId: bookId)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { [weak self] completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            print("Failed to upload Book Model: \(error)")
                            self?.phase = .fail
                        }
                    }, receiveValue: { _ in
                        self.books.append(newBook)
                        self.phase = .success
                    })
                    .store(in: &self.cancellables)
            }
            
        case .failure(let error):
            print("Failed to convert PDF data: \(error)")
        }
    }
}
