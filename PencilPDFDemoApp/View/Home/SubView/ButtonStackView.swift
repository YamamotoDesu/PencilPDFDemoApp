//
//  ButtonStackView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import SwiftUI

struct ButtonStackView: View {
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                Text("📚 내 책장")
                    .modifier(HeaderButtonModifier())
            })
            .padding(.trailing, 20)
            
            Button(action: {
                
            }, label: {
                Text("🏷️ 태그된 문제")
                    .modifier(HeaderButtonModifier())
            })
            
            Spacer()
        }
    }
}
