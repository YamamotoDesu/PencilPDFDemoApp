//
//  PDFViewModel.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Foundation

class PDFDrawingViewModel: ObservableObject {

    enum Action {
        case goToBackView
    }
    
    var book: Book
    private var container: DIContainer
    
    init(container: DIContainer,
         book: Book
    ) {
        self.container = container
        self.book = book
    }
    
    func send(action: Action) {
        switch action {
        case .goToBackView:
            container.navigationRouter.pop()
        }
    }
}
