//
//  NonSelectablePDFView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/30/24.
//

import UIKit
import PDFKit

class NonSelectablePDFView: PDFView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer is UILongPressGestureRecognizer {
            gestureRecognizer.isEnabled = false
        }
        
        super.addGestureRecognizer(gestureRecognizer)
    }
}
