//
//  HeaderButtonModifier.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/28/24.
//

import SwiftUI

struct HeaderButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.black)
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .strokeBorder(.black, lineWidth: 1)
            }
    }
}
