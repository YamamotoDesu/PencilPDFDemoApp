//
//  PDFView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import SwiftUI

struct PDFDrawingView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: PDFDrawingViewModel
    @State var toolType: DrawingTool = .pen
    
    var body: some View {
        VStack {
            DrawingToolBar
                .padding()
            
            PDFKitView(toolType: $toolType, data: viewModel.book.path)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.9)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    viewModel.send(action: .goToBackView)
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItemGroup(placement: .principal) {
                Text(viewModel.book.title)
                    .font(.title)
                    .foregroundStyle(.black)
            }
        }
    }
    
    var DrawingToolBar: some View {
        HStack {
            Button {
                toolType = .pen
            } label: {
                Text("Pen")
                    .font(.title2)
            }

            Button {
                toolType = .pencil
            } label: {
                Text("Pencil")
                    .font(.title2)
            }
            
            Button {
                toolType = .highlighter
            } label: {
                Text("Highlight")
                    .font(.title2)
            }
            
            Button {
                toolType = .eraser
            } label: {
                Text("Eraser")
                    .font(.title2)
            }
        }
    }
}
