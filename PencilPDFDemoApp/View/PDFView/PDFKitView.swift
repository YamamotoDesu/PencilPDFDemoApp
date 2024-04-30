//
//  PDFKitView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/30/24.
//

import SwiftUI
import UIKit
import PDFKit

struct PDFKitView: UIViewControllerRepresentable {
    @Binding var toolType: DrawingTool
//    var path: String
    var path: Data
    
    func makeUIViewController(context: Context) -> UIViewController {
//        guard let url = URL(string: path) else { return ErrorViewController() }
        let controller = PDFKitViewController(url: path)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class PDFKitViewController: UIViewController {
    
//    var url: URL
    var url: Data
    
    private var shouldUpdatePDFScrollPosition = true
    private let pdfDrawer = PDFDrawer()
    
    let pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.displayDirection = .vertical
        pdfView.usePageViewController(true)
        pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pdfView.autoScales = true
        pdfView.backgroundColor = .systemBackground
        return pdfView
    }()
    
    let thumbnailContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thumbnailView: PDFThumbnailView = {
        let thumbnailView = PDFThumbnailView()
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.pdfView = pdfView
        thumbnailView.thumbnailSize = CGSize(width: 100, height: 100)
        thumbnailView.layoutMode = .vertical
        thumbnailView.backgroundColor = .systemBackground
        return thumbnailView
    }()
    
    init(url: Data) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setGestureAndDrawer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if shouldUpdatePDFScrollPosition {
            fixPDFViewScrollPosition()
        }
    }
    
    private func fixPDFViewScrollPosition() {
        if let page = pdfView.document?.page(at: 0) {
            let position = CGPoint(x: 0, y: page.bounds(for: pdfView.displayBox).size.height)
            pdfView.go(to: PDFDestination(page: page, at: position))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shouldUpdatePDFScrollPosition = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        pdfView.autoScales = true
    }
    
    func setUI() {
        view.addSubview(pdfView)
        view.addSubview(thumbnailContainerView)
        thumbnailContainerView.addSubview(thumbnailView)
        
//        pdfView.document = PDFDocument(url: url)
//        pdfView.document = PDFDocument(data: url)
        guard let path = Bundle.main.url(forResource: "Test", withExtension: "pdf") else { return }
//        print(path)
        pdfView.document = PDFDocument(url: path)
        
        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pdfView.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            thumbnailContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            thumbnailContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            thumbnailContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thumbnailContainerView.widthAnchor.constraint(equalToConstant: 132),
            
            thumbnailView.topAnchor.constraint(equalTo: thumbnailContainerView.topAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: thumbnailContainerView.bottomAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: thumbnailContainerView.leadingAnchor),
            thumbnailView.trailingAnchor.constraint(equalTo: thumbnailContainerView.trailingAnchor)
        ])
    }
    
    func setGestureAndDrawer() {
        let pdfDrawingGestureRecognizer = DrawingGestureRecognizer()
        pdfView.addGestureRecognizer(pdfDrawingGestureRecognizer)
        pdfDrawingGestureRecognizer.drawingDelegate = pdfDrawer
        pdfDrawer.pdfView = pdfView
    }
    
    func changeDrawingTool(tool: DrawingTool) {
        pdfDrawer.drawingTool = tool
    }
}
