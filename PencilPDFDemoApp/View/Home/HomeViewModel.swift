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
//        case makeNewBook(String, String, Int)
        case makeNewBook(URL?)
        case goToPDF(Book)
    }
    
    @Published var books = [Book]()
    
    private var container: DIContainer
    
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
                
                let newBook = Book(title: url.lastPathComponent, path: "\(url)", curPage: 1, maxPage: 1, totalPage: pageCount)
                books.append(newBook)
                container.services.realmService.addBook(book: newBook)
            }
            
        case .goToPDF(let book):
            container.navigationRouter.push(to: .pdf(book: book))
        }
    }
}
