//
//  MeView.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/3/25.
//

import SwiftUI

struct MeView: View {
    @Environment(\.tabConfig) var tabConfig
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button("Go to everyone") {
                tabConfig.selectedTab = .everyone
            }
        }
    }
}

#Preview {
    MeView()
}
