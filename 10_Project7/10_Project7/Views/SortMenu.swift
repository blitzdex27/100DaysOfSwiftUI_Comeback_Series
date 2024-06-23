//
//  SortMenu.swift
//  10_Project7
//
//  Created by Dexter Ramos on 6/23/24.
//

import SwiftUI
import SwiftData

struct SortMenu<SortItem>: View {
    @Binding var selection: [SortDescriptor<SortItem>]
    
    var options: [Option]
    
    var title: String {
        for option in options {
            if option.sortDescriptor == selection {
                return option.title
            }
        }
        return ""
    }
    var body: some View {
        Menu(title, systemImage: "arrow.up.arrow.down") {
            Picker("", selection: $selection) {
                ForEach(options, id: \.title) { option in
                    Text(option.title)
                        .tag(option.sortDescriptor)
                }
            }
        }
    }
}

extension SortMenu {
    struct Option {
        var title: String
        var sortDescriptor: [SortDescriptor<SortItem>]
    }
}


#Preview {
    SortMenu(selection: .constant([
        SortDescriptor<Expense>(\.dateCreated)
    ]), options: [
        .init(title: "Date created", sortDescriptor: [
            SortDescriptor(\.dateCreated)
        ])
    ])
}
