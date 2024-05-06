//
//  DBERror.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/3/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
