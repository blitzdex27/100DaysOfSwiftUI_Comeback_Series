//
//  MeView.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/3/25.
//

import SwiftUI

struct MeView: View {
    @Environment(\.tabConfig) var tabConfig
    
    @AppStorage("name") var name = "Annonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    
    @State var qrCode = UIImage()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Email address", text: $emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
            }
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    
    func updateCode() {
        qrCode = "\(name)\n\(emailAddress)".generateQRCode()
    }
}

#Preview {
    MeView()
}
