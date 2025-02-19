//
//  RollResultsView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/18/25.
//

import SwiftUI
import SwiftData

struct RollResultsView: View {
    @Environment(\.modelContext) var modelContext

    @State var vm = ViewModel()
    
    var body: some View {

        VStack {
            if vm.rollResults.isEmpty {
               
                    Text("No results yet.")
                    .font(.caption)
                
            } else {
                List {
                    ForEach(vm.rollResults) { result in
                        HStack {
                            Text("\(result.result)")
                                .font(.callout)
                            Spacer()
                            Text("\(result.values.map(String.init).formatted())")
                                .font(.caption)
                        }
                    }
                    .navigationTitle("Roll Results")

                }
            }
        }
        .onAppear(perform: RollResultStore.shared.fetchResults)
        .toolbar {
            Button("Clear", action: vm.clear)
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    VStack {
        Text("Test")
        Button("History") {
            isPresented = true
        }
    }
        .sheet(isPresented: $isPresented) {
            RollResultsView()
        }
}
