//
//  CanvasDrawingView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/6/24.
//

import UIKit
import SwiftUI
import PencilKit

struct CanvasDrawingRepresentableView: UIViewRepresentable {
    @State var canvasView = PKCanvasView()
    @Binding var tool: PKTool
    @Binding var drawing: PKDrawing
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = tool
        canvasView.drawing = drawing
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = context.coordinator
        canvasView.backgroundColor = .clear
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = tool
        uiView.drawing = drawing
    }
}

extension CanvasDrawingRepresentableView {
    
    final class Coordinator: NSObject, PKCanvasViewDelegate {
        let onSaved: () -> Void
        
        init(onSaved: @escaping () -> Void) {
            self.onSaved = onSaved
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            if !canvasView.drawing.bounds.isEmpty {
                onSaved()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onSaved: saveDrawing)
    }
    
    private func saveDrawing() {
        drawing = canvasView.drawing
    }
}
