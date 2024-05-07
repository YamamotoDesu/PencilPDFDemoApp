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
    
    var cellWidth = UIScreen.main.bounds.width
    var cellHeight = UIScreen.main.bounds.height - 120
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            PDFViewNavigationBar(viewModel: viewModel)
            
            Divider()
                .frame(width: cellWidth)
            
            DrawingToolBar(viewModel: viewModel)
            
            Divider()
                .frame(width: cellWidth)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(cellHeight))], spacing: 0) {
                    ForEach(viewModel.book.pdfImageURLs.indices, id: \.self) { idx in
                        CanvasDrawingPageView(tool:  $viewModel.selectedTool,
                                              drawing: $viewModel.drawings[idx],
                                              pagePDFImageUrl: viewModel.book.pdfImageURLs[idx],
                                              width: cellWidth,
                                              height: cellHeight)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .sheet(isPresented: $viewModel.isLoading) {
            LoadingView(loadingType: .save)
                .shadow(radius: 20)
        }
    }
}
