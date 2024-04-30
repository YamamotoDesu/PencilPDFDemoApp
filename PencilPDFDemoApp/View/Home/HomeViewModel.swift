//
//  HomeViewModel.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/28/24.
//

import Foundation
import PDFKit

final class HomeViewModel: ObservableObject {
    
    enum Action {
        case makeNewBook(URL?)
        case goToPDF(Book)
    }
    
    @Published var books = [Book]()
    
    private var container: DIContainer
    private let manager = FileManager.default
    
    init(container: DIContainer) {
        self.container = container
        self.books = try! container.services.realmService.fetchBooks()
    }
    
    func send(action: Action) {
        switch action {
        case .makeNewBook(let url):
            guard let url = url else { return }
            
            if url.startAccessingSecurityScopedResource() {
                guard let pageCount = PDFDocument(url: url)?.pageCount else { return }
                defer { url.stopAccessingSecurityScopedResource() }
                
                do {
                    let pdfData: Data = try Data(contentsOf: url)
//                    guard let localURL: URL = container.services.fileManagingService
//                        .copyPDF(data: pdfData, name: "\(url.lastPathComponent)") else { return }
                    
                    let newBook = Book(title: url.lastPathComponent,
                                       path: pdfData,
                                       curPage: 1,
                                       maxPage: 1,
                                       totalPage: pageCount)
                    
                    books.append(newBook)
                    container.services.realmService.addBook(book: newBook)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        case .goToPDF(let book):
            container.navigationRouter.push(to: .pdf(book: book))
        }
    }
}
