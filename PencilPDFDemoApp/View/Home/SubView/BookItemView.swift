//
//  BookItemView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import SwiftUI

struct BookItemView: View {
    var title: String
    var progress: Int
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .strokeBorder(.black, lineWidth: 1)
                    .frame(height: 220)
                    
                Image(systemName: "book")
                    .font(.title)
                    .foregroundStyle(.black)
            }
                
            Text(title)
                .font(.title2)
                .foregroundStyle(.black)
                .lineLimit(2)
            
            Text("\(progress)%")
                .foregroundStyle(.black)
        }
        .frame(width: 180)
    }
}
