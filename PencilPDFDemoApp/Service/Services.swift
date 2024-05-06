//
//  Services.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Foundation

protocol ServiceType {
    var bookService: BookServiceType { get set }
    var uploadService: UploadServiceType { get set }
}

final class Services: ServiceType {
    var bookService: BookServiceType
    var uploadService: UploadServiceType
    
    init() {
        self.bookService = BookService(dbRepository: BookDBRepository())
        self.uploadService = UploadService(provider: UploadProvider())
    }
}

final class StubServices: ServiceType {
    var bookService: BookServiceType = StubBookService()
    var uploadService: UploadServiceType = StubUploadService()
}
