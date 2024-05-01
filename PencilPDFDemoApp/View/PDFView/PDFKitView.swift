//
//  PDFKitView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/30/24.
//

import SwiftUI
import UIKit
import PDFKit
import PencilKit

struct PDFKitView: UIViewControllerRepresentable {
    @Binding var toolType: DrawingTool
    var data: Data
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = PDFKitViewController(data: data)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class PDFKitViewController: UIViewController {
    
    var data: Data
    let pdfView = PDFView(frame: CGRect(x: 0, y: 0, 
                                        width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height * 0.9))
    let canvasView = PKCanvasView()
    
    init(data: Data) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.addSubview(pdfView)
        view.addSubview(canvasView)
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.usePageViewController(true)
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .horizontal
        pdfView.document = PDFDocument(data: data)
        
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.backgroundColor = .clear
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 10)
        
        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            canvasView.topAnchor.constraint(equalTo: view.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
