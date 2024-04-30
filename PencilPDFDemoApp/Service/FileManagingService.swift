//
//  FileManagingService.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/30/24.
//

import Foundation

protocol FileManagingServiceType {
    func copyPDF(data: Data, name: String) -> URL?
}

final class FileManagingService: FileManagingServiceType {
    private let documentPathName: String = "PencilPDFDemo"
    
    init() {
        createFolderIfNeeded()
    }
    
    func copyPDF(data: Data, name: String) -> URL? {
        guard let path = getPathForName(name: name) else { return nil }
        print(path)
        do {
            try data.write(to: path)
            return path
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func createFolderIfNeeded() {
        guard let path = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent(documentPathName).path else { return }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getPathForName(name: String) -> URL? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent(documentPathName)
            .appendingPathComponent("\(name)") else { return nil }
        
        return path
    }
}

final class StubFileManagingService: FileManagingServiceType {
    
    func copyPDF(data: Data, name: String) -> URL? {
        return URL(string: "Test")
    }
}
