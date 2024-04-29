//
//  Book.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/28/24.
//

import Foundation
import RealmSwift

struct Book: Hashable {
    let id: String
    var title: String
    let path: String
    var progress: Int
    var curPage: Int
    var maxPage: Int
    let totalPage: Int
    
    init(id: ObjectId = ObjectId.generate(), title: String, path: String, curPage: Int, maxPage: Int, totalPage: Int) {
        self.id = id.stringValue
        self.title = title
        self.path = path
        self.progress = maxPage / totalPage * 100
        self.curPage = curPage
        self.maxPage = maxPage
        self.totalPage = totalPage
    }
}
