//
//  BookRepository.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/3/24.
//

import Combine
import FirebaseDatabase
import Foundation

protocol BookDBRepositoryType {
    func addBook(_ object: BookObject, bookId: String) -> AnyPublisher<Void, DBError>
    func getBooks() -> AnyPublisher<[BookObject], DBError>
}

class BookDBRepository: BookDBRepositoryType {
    var db: DatabaseReference = Database.database().reference()
    
    func addBook(_ object: BookObject, bookId: String) -> AnyPublisher<Void, DBError> {
        Just(object)
            .compactMap { try? JSONEncoder().encode($0) }
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed) }
            .flatMap { value in
                return Future<Void, DBError> { [weak self] promise in
                    self?.db.child(DBKey.Books).child(bookId).setValue(value) { error, _ in
                        if let error {
                            promise(.failure(.error(error)))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getBooks() -> AnyPublisher<[BookObject], DBError> {
        Future<Any?, DBError> { [weak self] promise in
            self?.db.child(DBKey.Books).getData { error, snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value))
                }
            }
        }
        .flatMap { value in
            if let dic = value as? [String: [String: Any]] {
                return Just(dic)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                    .decode(type: [String: BookObject].self, decoder: JSONDecoder())
                    .map { $0.values.map { $0 as BookObject } }
                    .mapError { DBError.error($0) }
                    .eraseToAnyPublisher()
            } else if value == nil {
                return Just([]).setFailureType(to: DBError.self).eraseToAnyPublisher()
            } else {
                return Fail(error: .invalidatedType).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}
