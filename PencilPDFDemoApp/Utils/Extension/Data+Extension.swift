//
//  Data+Extension.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/4/24.
//

import Combine
import Foundation
import PDFKit

enum DataError: Error {
    case pdfConvertFailed
}

extension Data {
    func convertPDFToImageDatas() -> Result<[Int: Data], DataError> {
        guard let pdfDocument = PDFDocument(data: self) else {
            return .failure(.pdfConvertFailed)
        }
        
        var dataDict = [Int: Data]()
        
        for pageNum in 0..<pdfDocument.pageCount {
            if let pdfPage = pdfDocument.page(at: pageNum) {
                let pdfPageSize = pdfPage.bounds(for: .mediaBox)
                let renderer = UIGraphicsImageRenderer(size: pdfPageSize.size)
                
                let image = renderer.image { ctx in
                    UIColor.white.set()
                    ctx.fill(pdfPageSize)
                    ctx.cgContext.translateBy(x: 0.0, y: pdfPageSize.size.height)
                    ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                    
                    pdfPage.draw(with: .mediaBox, to: ctx.cgContext)
                }
                
                if let imageData = image.pngData() {
                    dataDict[pageNum] = imageData
                }
            }
        }
        
        return .success(dataDict)
    }
}
