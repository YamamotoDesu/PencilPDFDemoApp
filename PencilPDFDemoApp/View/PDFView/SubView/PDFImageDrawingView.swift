//
//  PDFImageDrawingView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/1/24.
//

import SwiftUI
import UIKit
import PencilKit

struct CanvasDrawingPageView: View {
    // MARK: - Zoom 및 Drag를 위한 Property
    @State private var scale: CGFloat = 1.0
    @State private var xOffset: CGFloat = 0.0
    @State private var yOffset: CGFloat = 0.0
    @GestureState private var magnification = CGFloat(1.0)
    @GestureState private var dragOffset = CGSize.zero
    
    // MARK: - CanvasView에 전달하기 위한 Property
    @Binding private var tool: PKTool
    @Binding private var drawing: PKDrawing
    var pagePDFImageUrl: String
    var width: CGFloat
    var height: CGFloat
    
    init(tool: Binding<PKTool>,
         drawing: Binding<PKDrawing>,
         pagePDFImageUrl: String,
         width: CGFloat,
         height: CGFloat
    ) {
        self._tool = tool
        self._drawing = drawing
        self.pagePDFImageUrl = pagePDFImageUrl
        self.width = width
        self.height = height
    }
    
    // MARK: - Zoom Gesture
    var magnificationGesture: some Gesture {
        MagnificationGesture()
            .updating($magnification) { value, gestureState, transaction in
                gestureState = value
            }
            .onEnded { value in
                self.scale *= value
                if self.scale <= 1.0 {
                    self.scale = 1.0
                    self.xOffset = 0.0
                    self.yOffset = 0.0
                }
            }
    }
    
    // MARK: - Drag Gesture
    var dragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                if self.scale > 1.0 {
                    state = value.translation
                }
            }
            .onEnded { value in
                if self.scale > 1.0 {
                    self.xOffset += value.translation.width
                    self.yOffset += value.translation.height
                    
                    let maxXOffset = (width * self.scale) / 2
                    let maxYOffset = (height * self.scale) / 2
                    
                    if xOffset < -maxXOffset {
                        self.xOffset = -maxXOffset
                    } else if xOffset > maxXOffset {
                        self.xOffset = maxXOffset
                    }
                    
                    if yOffset < -maxYOffset {
                        self.yOffset = -maxYOffset
                    } else if yOffset > maxYOffset {
                        self.yOffset = maxYOffset
                    }
                }
            }
    }
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: pagePDFImageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            
            CanvasDrawingRepresentableView(tool: $tool, drawing: $drawing)
        }
        .background(.white)
        .scaleEffect(scale * magnification)
        .offset(x: xOffset + dragOffset.width, y: yOffset + dragOffset.height)
        .clipped()
        .gesture(magnificationGesture.simultaneously(with: dragGesture))
        .frame(width: width, height: height)
    }
}
