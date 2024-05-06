//
//  BookService.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/4/24.
//

import Combine
import Foundation

protocol BookServiceType {
    func addBook(_ book: Book, bookId: String) -> AnyPublisher<Void, ServiceError>
    func getBooks() -> AnyPublisher<[Book], ServiceError>
}

final class BookService: BookServiceType {
    private var dbRepository: BookDBRepositoryType
    
    init(dbRepository: BookDBRepositoryType) {
        self.dbRepository = dbRepository
    }
    
    func addBook(_ book: Book, bookId: String) -> AnyPublisher<Void, ServiceError> {
        return dbRepository.addBook(book.toObject(), bookId: bookId)
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }
    
    func getBooks() -> AnyPublisher<[Book], ServiceError> {
        dbRepository.getBooks()
            .map { $0.map { $0.toModel() } }
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }
}

final class StubBookService: BookServiceType {
    func addBook(_ book: Book, bookId: String) -> AnyPublisher<Void, ServiceError> {
        Empty().setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func getBooks() -> AnyPublisher<[Book], ServiceError> {
        Just([.stub1, .stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
}
