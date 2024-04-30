//
//  RealmService.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Foundation
import RealmSwift
import Combine

protocol RealmServiceType {
    func fetchBooks() throws -> [Book]
    func addBook(book: Book)
}

final class RealmService: RealmServiceType {
    func fetchBooks() throws -> [Book] {
        do {
            let realm = try Realm()
            let books = realm.objects(RMBook.self)
            return books.map { $0.asLocal() }
        } catch {
            throw error
        }
    }
    
    func addBook(book: Book) {
        do {
            let realm = try Realm()
            let rmBook = book.asRealm()
            
            try! realm.write {
                realm.add(rmBook)
            }
        } catch {
            print("addBook error")
        }
    }
}

final class StubRealmService: RealmServiceType {
    private var books = [Book]()
    
    func fetchBooks() throws -> [Book] {
        for i in 1...20 {
            let stub = Book(title: "테스트 파일 \(i)", path: Data(), curPage: i, maxPage: i + 3, totalPage: i * 20)
            books.append(stub)
        }
        
        return books
    }
    
    func addBook(book: Book) {
        books.append(book)
    }
}
