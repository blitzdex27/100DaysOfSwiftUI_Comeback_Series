//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Dexter  on 7/29/24.
//

import SwiftUI
import SwiftData

struct ProspectsView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    let filter: FilterType
    
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
    
    init(filter: FilterType) {
        self.filter = filter
        let showContactedOnly = filter == .contacted
        
        if filter != .none {
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
    
    var body: some View {
        NavigationStack {
            List(prospects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
    
    enum FilterType {
        case none, contacted, uncontacted
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
