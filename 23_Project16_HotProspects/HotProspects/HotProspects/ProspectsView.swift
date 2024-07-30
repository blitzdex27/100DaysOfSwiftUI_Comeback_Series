//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Dexter  on 7/29/24.
//

import SwiftUI
import SwiftData

struct ProspectsView: View {
    @Environment(\.modelContext) var modelContext
    
    let filter: ProspectViewList.FilterType
    
    @State private var sortMethod: ProspectViewList.SortMethod = .name
    
    @State private var showingProspectView = false
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    
    init(filter: ProspectViewList.FilterType) {
        self.filter = filter
    }
    
    var body: some View {
        NavigationStack {
            ProspectViewList(filter: filter, sort: sortMethod)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem {
                    Menu(sortMethod.rawValue, systemImage: "arrow.up.arrow.down") {
                        Picker("''", selection: $sortMethod) {
                            ForEach(ProspectViewList.SortMethod.allCases, id: \.self) { sort in
                                Text(sort.rawValue)
                            }
                        }
                    }
                }
                ToolbarItem {
                    Button("Add") {
                        showingProspectView = true
                    }
                }
            }
            .sheet(isPresented: $showingProspectView) {
                EditProspectView { prospect in
                    modelContext.insert(prospect)
                }
            }
        }
    }
    
  
}

//#Preview {
//    ProspectsView(filter: .none)
//        .modelContainer(for: Prospect.self)
//}
