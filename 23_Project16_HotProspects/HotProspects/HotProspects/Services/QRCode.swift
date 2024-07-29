//
//  QRCode.swift
//  HotProspects
//
//  Created by Dexter  on 7/29/24.
//

import Foundation
import CoreImage.CIFilterBuiltins
import UIKit


class QRCode {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generate(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.message = data
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmar.circle") ?? UIImage()
    }
    
    static func generate(from string: String) -> UIImage {
        let qrCode = QRCode()
        return qrCode.generate(from: string)
    }
}
