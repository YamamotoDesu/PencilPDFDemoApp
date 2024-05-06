//
//  BookObject.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/3/24.
//

import Foundation

struct BookObject: Codable {
    let id: String
    var title: String
    let pdfImageURLs: [String]
    var curPage: Int
    var maxPage: Int
    let totalPage: Int
}

extension BookObject {
    func toModel() -> Book {
        .init(id: id,
              title: title,
              pdfImageURLs: pdfImageURLs,
              progress: maxPage / totalPage * 100,
              curPage: curPage,
              maxPage: maxPage,
              totalPage: totalPage)
    }
}
