//
//  Book.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/28/24.
//

import Foundation

struct Book: Hashable, Identifiable {
    let id: String
    var title: String
    let pdfImageURLs: [String]
    var progress: Int
    var curPage: Int
    var maxPage: Int
    let totalPage: Int
}

extension Book {
    func toObject() -> BookObject {
        .init(id: id,
              title: title,
              pdfImageURLs: pdfImageURLs,
              curPage: curPage,
              maxPage: maxPage,
              totalPage: totalPage)
    }
}

extension Book {
    static var stub1: Book {
        .init(id: "book1_id", title: "기출문제 모음집", pdfImageURLs: [], progress: 20, curPage: 3, maxPage: 10, totalPage: 50)
    }
    
    static var stub2: Book {
        .init(id: "book2_id", title: "전기기사 기출", pdfImageURLs: [], progress: 10, curPage: 2, maxPage: 30, totalPage: 300)
    }
}
