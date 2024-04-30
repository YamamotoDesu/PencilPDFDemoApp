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
    
    var body: some View {
        VStack {
            PDFKitView(path: viewModel.book.path)
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
}
