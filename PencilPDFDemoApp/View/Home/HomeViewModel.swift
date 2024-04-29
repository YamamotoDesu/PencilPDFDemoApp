//
//  HomeViewModel.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/28/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    enum Action {
        case makeNewBook(String, String, Int)
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
        case .makeNewBook(let title, let url, let totalPage):
            let newBook = Book(title: title, path: url, curPage: 1, maxPage: 1, totalPage: totalPage)
            books.append(newBook)
            container.services.realmService.addBook(book: newBook)
            
        case .goToPDF(let book):
            container.navigationRouter.push(to: .pdf(book: book))
        }
    }
}
