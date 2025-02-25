//
//  RollResultsView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/18/25.
//

import SwiftUI
import SwiftData

struct RollResultsView: View {
    @State var vm: ViewModel
    @Query(sort: \RollResult.persistentModelID, order: .reverse) var rollResults: [RollResult]
    
    init(viewModel: ViewModel) {
        _vm = State(initialValue: viewModel)
    }
    
    var body: some View {

        VStack {
            if rollResults.isEmpty {
               
                    Text("No results yet.")
                    .font(.caption)
                
            } else {
                List {
                    ForEach(rollResults) { result in
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
        .onAppear(perform: vm.fetchResults)
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
            RollResultsView(viewModel: .init(store: .defaultValue))
        }
}
