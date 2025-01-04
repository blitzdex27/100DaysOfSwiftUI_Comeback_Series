//
//  ProspectsView.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/3/25.
//

import SwiftUI

struct ProspectsView: View {
    
    enum FilterType {
        case everyone
        case contacted
        case uncontacted
    }
    
    let filter: FilterType
    
    
    var title: String {
        switch filter {
        case .everyone:
            "Everyone"
        case .contacted:
            "Contacted"
        case .uncontacted:
            "Uncontacted"
        }
    }
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle(title)
        }
    }
}

#Preview {
    ProspectsView(filter: .everyone)
}
