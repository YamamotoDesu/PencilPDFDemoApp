//
//  PDFKitView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/30/24.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let path: String
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        guard let url = URL(string: path) else { return pdfView }
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}
