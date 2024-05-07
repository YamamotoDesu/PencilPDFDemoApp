//
//  UIColor+Extension.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/7/24.
//

import UIKit

extension UIColor {
    static let pencilRed = UIColor(hexCode: "F85151")
    static let pencilBlue = UIColor(hexCode: "6C9DFE")
    
    static let highlightYello = UIColor(hexCode: "FFFCB7")
    static let highlightPink = UIColor(hexCode: "FFDAFB")
    static let highlightGreen = UIColor(hexCode: "D2FDD6")
}

extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
