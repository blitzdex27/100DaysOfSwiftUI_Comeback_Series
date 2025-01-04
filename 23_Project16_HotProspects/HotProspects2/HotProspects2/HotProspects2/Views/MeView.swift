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
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Email address", text: $emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                Image(uiImage: "\(name)\n\(emailAddress)".generateQRCode())
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    MeView()
}
