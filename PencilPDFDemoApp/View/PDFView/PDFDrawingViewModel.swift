//
//  PDFViewModel.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Combine
import UIKit
import PencilKit

enum ToolType: String, CaseIterable {
    case pen = "pencil"
    case highlight = "pencil.tip"
    case eraser = "eraser"
}

class PDFDrawingViewModel: ObservableObject {

    enum Action {
        case goToBackView
    }
    
    var container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    var book: Book
    var drawings = [PKDrawing]()
    
    var pencilWidthArr: [Double] = [1.0, 3.0, 6.0]
    var highlightWidthArr: [Double] = [4.0, 8.0, 12.0]
    var eraserWidthArr: [Double] = [28.0, 40.0, 52.0]
    
    var pencilColorArr: [UIColor] = [.black, .blue, .red]
    var highlightColorArr: [UIColor] = [.yellow, .green, .systemPink]
    
    // MARK: - 선택한 ToolType
    @Published var selectedToolType: ToolType = .pen {
        didSet {
            updateSelectedTool()
        }
    }
    
    // MARK: - 선택한 ToolType에 따른 Width
    @Published var selectedPencilWidth: Double = 1.0 {
        didSet {
            updateSelectedTool()
        }
    }
    
    @Published var selectedHighlightWidth: Double = 4.0 {
        didSet {
            updateSelectedTool()
        }
    }
    
    @Published var selectedEraserWidth: Double = 28.0 {
        didSet {
            updateSelectedTool()
        }
    }
    
    // MARK: - 선택한 ToolType에 따른 Color
    @Published var selectedPencilColor: UIColor = .black {
        didSet {
            updateSelectedTool()
        }
    }
    
    @Published var selectedHighlightColor: UIColor = .yellow {
        didSet {
            updateSelectedTool()
        }
    }
    
    // MARK: - 최종적으로 선택된 Tool
    @Published var selectedTool: PKTool = PKInkingTool(ink: PKInk(.pen, color: .black), width: 1.0)
    
    init(container: DIContainer,
         book: Book
    ) {
        self.container = container
        self.book = book
        
        if DrawingFileManager.share.checkDirectory(bookId: book.id) {
            print(1)
            let datas = DrawingFileManager.share.getDrawingDatas(bookId: book.id, totalPage: book.totalPage)
            for data in datas {
                do {
                    let drawing = try PKDrawing(data: data)
                    drawings.append(drawing)
                } catch {
                    print(error.localizedDescription)
                }
            }
        } else {
            DrawingFileManager.share.makeDirectory(bookId: book.id)
            drawings = Array(repeating: PKDrawing(), count: book.pdfImageURLs.count)
        }
    }
    
    func send(action: Action) {
        switch action {
        case .goToBackView:
            saveDrawings()
            container.navigationRouter.pop()
        }
    }
    
    private func updateSelectedTool() {
        switch selectedToolType {
        case .pen:
            self.selectedTool = PKInkingTool(ink: PKInk(.pen, color: selectedPencilColor),
                                             width: selectedPencilWidth)
        case .highlight:
            self.selectedTool = PKInkingTool(ink: PKInk(.marker, color: selectedHighlightColor),
                                             width: selectedHighlightWidth)
        case .eraser:
            self.selectedTool = PKEraserTool(.bitmap, width: selectedEraserWidth)
        }
    }
    
    private func saveDrawings() {
        let datas = drawings.map { $0.dataRepresentation() }
        DrawingFileManager.share.saveDrawingDatas(datas: datas, bookId: book.id)
    }
}
