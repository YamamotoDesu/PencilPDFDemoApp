//
//  UploadSourceType.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/4/24.
//

import Foundation

enum UploadSourceType {
    case pdfData(bookId: String)
    
    var path: String {
        switch self {
        case let .pdfData(bookId):
            return "\(DBKey.Books)/\(bookId)/PDF"
        }
    }
}
