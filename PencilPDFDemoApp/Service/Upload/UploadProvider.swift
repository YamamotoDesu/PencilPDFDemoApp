//
//  UploadProvider.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/4/24.
//

import Combine
import Foundation
import FirebaseStorage
import FirebaseStorageCombineSwift

enum UploadError: Error {
    case error(Error)
}

protocol UploadProviderType {
    func upload(path: String, data: Data, fileName: String) -> AnyPublisher<URL, UploadError>
}

class UploadProvider: UploadProviderType {
    let storageRef = Storage.storage().reference()
    
    func upload(path: String, data: Data, fileName: String) -> AnyPublisher<URL, UploadError> {
        let ref = storageRef.child(path).child(fileName)
        
        return ref.putData(data)
            .flatMap { _ in
                ref.downloadURL()
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}
