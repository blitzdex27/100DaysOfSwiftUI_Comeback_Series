//
//  ContentWrapperView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/22/25.
//

import SwiftUI

struct ContentWrapperView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var loadingOver = false
    @State var store: RollResultStore!
    
    var body: some View {
        if loadingOver {
            ContentView(viewModel: .defaultVM(store: store))
                .environment(\.rollResultStore, store)
        } else {
            LoadingView()
                .onAppear(perform: setup)
        }
            
    }
    
    func setup() {
        store = RollResultStore(modelContext: modelContext)
        loadingOver = true
    }
}

#Preview {
    ContentWrapperView()
}
