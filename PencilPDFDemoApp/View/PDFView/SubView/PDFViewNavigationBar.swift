//
//  PDFViewNavigationBar.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/1/24.
//

import SwiftUI

struct PDFViewNavigationBar: View {
    @ObservedObject var viewModel: PDFDrawingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button {
                    viewModel.send(action: .goToBackView)
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.black)
                }
                .padding(.leading, 20)
                
                Spacer()
                
                Text(viewModel.book.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
        .background(.backgroundGray)
        .frame(height: 80)
    }
}
