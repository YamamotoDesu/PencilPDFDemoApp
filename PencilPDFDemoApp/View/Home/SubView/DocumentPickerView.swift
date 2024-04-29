//
//  DocumentPickerView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import UIKit
import SwiftUI
import MobileCoreServices
import PDFKit

struct DocumentPickerView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: HomeViewModel
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPickerView = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        documentPickerView.delegate = context.coordinator
        documentPickerView.allowsMultipleSelection = false
        documentPickerView.modalPresentationStyle = .formSheet
        return documentPickerView
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPickerView
        
        init(_ parent: DocumentPickerView) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first, let pageCount = PDFDocument(url: url)?.pageCount else { return }
            parent.viewModel.send(action: .makeNewBook(url.lastPathComponent, "\(url)", pageCount))
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
