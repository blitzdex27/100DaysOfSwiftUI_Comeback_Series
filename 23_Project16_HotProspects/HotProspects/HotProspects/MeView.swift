//
//  MeView.swift
//  HotProspects
//
//  Created by Dexter  on 7/29/24.
//

import SwiftUI

struct MeView: View {
    
    @State private var qrCode = UIImage()
    
    let name: String
    let emailAddress: String
    
    var body: some View {
        Image(uiImage: qrCode)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .contextMenu {
                ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
            }
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
    }
    func updateCode() {
        qrCode = QRCode.generate(from: "\(name)\n\(emailAddress)")
    }
}

#Preview {
    MeView(name: "", emailAddress: "")
}
