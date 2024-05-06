//
//  PDFView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import SwiftUI
import PencilKit

struct PDFDrawingView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: PDFDrawingViewModel
    
    var body: some View {
        VStack {
            PDFViewNavigationBar(viewModel: viewModel)
            
            DrawingToolBar(viewModel: viewModel)
            
            Spacer()
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(UIScreen.main.bounds.height * 0.8))]) {
                    ForEach(viewModel.book.pdfImageURLs.indices, id: \.self) { idx in
                        CanvasDrawingPageView(tool:  $viewModel.selectedTool,
                                              drawing: $viewModel.drawings[idx],
                                              pagePDFImageUrl: viewModel.book.pdfImageURLs[idx])
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
    }
}
