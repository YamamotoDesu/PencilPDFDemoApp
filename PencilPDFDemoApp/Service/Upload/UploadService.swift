//
//  UploadService.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/4/24.
//

import Combine
import Foundation

protocol UploadServiceType {
    func uploadPDFData(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError>
}

final class UploadService: UploadServiceType {
    private let provider: UploadProviderType
    
    init(provider: UploadProviderType) {
        self.provider = provider
    }
    
    func uploadPDFData(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError> {
        provider.upload(path: source.path, data: data, fileName: UUID().uuidString)
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}

final class StubUploadService: UploadServiceType {
    func uploadPDFData(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError> {
        Empty().setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
}
