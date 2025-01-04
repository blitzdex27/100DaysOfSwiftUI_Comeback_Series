//
//  String+QRCode.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/4/25.
//
import UIKit
import CoreImage.CIFilterBuiltins

extension String {
    func generateQRCode() -> UIImage {
        let ciContext = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        let defaultImage = UIImage(systemName: "x.circle") ?? UIImage()
        
        if let data = data(using: .utf8) {
            filter.message = data
            
            if let outputImage = filter.outputImage,
               let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return defaultImage
        
        
    }
}
