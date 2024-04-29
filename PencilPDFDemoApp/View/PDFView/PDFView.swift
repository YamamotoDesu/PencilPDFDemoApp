//
//  PDFView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import SwiftUI

struct PDFView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: PDFViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.book.title)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    viewModel.send(action: .goToBackView)
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
            
            ToolbarItemGroup(placement: .principal) {
                Text(viewModel.book.title)
            }
        }
    }
}
