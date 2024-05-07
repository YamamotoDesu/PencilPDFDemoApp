//
//  BookItemEmptyCell.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import SwiftUI

struct BookItemEmptyCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .strokeBorder(.blue, style: .init(lineWidth: 1, dash: [5]))
                    .frame(height: 220)
                    
                Image(systemName: "arrowshape.turn.up.right")
                    .font(.title)
            }
                
            Text("PDF 업로드하기")
                .font(.title3)
                .foregroundStyle(.black)
            
            Spacer()
        }
        .frame(width: 180)
    }
}
