//
//  ContentView.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 12/21/24.
//

import SwiftUI

struct ContentView: View {
    
    

    @State var tabConfig: TabConfig = .init()
    
    var body: some View {
        TabView(selection: $tabConfig.selectedTab) {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
                .tag(TabEnum.everyone)
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
                .tag(TabEnum.contacted)
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
                .tag(TabEnum.notContacted)
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
                .tag(TabEnum.me)
        }
        .environment(\.tabConfig, tabConfig)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Prospect.self)
}
