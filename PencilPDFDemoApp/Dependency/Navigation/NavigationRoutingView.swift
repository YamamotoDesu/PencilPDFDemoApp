//
//  NavigationRoutingView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .pdf(let book):
            PDFDrawingView(viewModel: .init(container: container, book: book))
        }
    }
}
