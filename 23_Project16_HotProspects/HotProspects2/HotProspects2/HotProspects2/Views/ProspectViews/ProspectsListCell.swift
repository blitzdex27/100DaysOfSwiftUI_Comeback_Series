//
//  ProspectsListCell.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/5/25.
//

import SwiftUI

struct ProspectsListCell: View {
    
    let prospect: Prospect
    let filter: ProspectsView.FilterType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.emailAddress)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            if filter == .none {
                Spacer()
                let name = prospect.isContacted ? "checkmark.circle" : "exclamationmark.circle"
                Image(systemName: name)
                    .foregroundStyle(prospect.isContacted ? .green : .orange)
            }
            
        }
    }
}

//#Preview {
//    ProspectsListCell()
//}
