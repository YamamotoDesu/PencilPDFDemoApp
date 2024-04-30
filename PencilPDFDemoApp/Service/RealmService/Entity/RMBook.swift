//
//  RMBook.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Foundation
import RealmSwift

class RMBook: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var path: Data
    @Persisted var curPage: Int
    @Persisted var maxPage: Int
    @Persisted var totalPage: Int
}

extension RMBook: LocalConvertibleType {
    func asLocal() -> Book {
        return Book(id: id,
                    title: title,
                    path: path,
                    curPage: curPage,
                    maxPage: maxPage,
                    totalPage: totalPage)
    }
}

extension Book: RealmRepresentable {
    func asRealm() -> RMBook {
        return RMBook.build { object in
            object.id = try! ObjectId(string: id)
            object.title = title
            object.path = path
            object.curPage = curPage
            object.maxPage = maxPage
            object.totalPage = totalPage
        }
    }
}
