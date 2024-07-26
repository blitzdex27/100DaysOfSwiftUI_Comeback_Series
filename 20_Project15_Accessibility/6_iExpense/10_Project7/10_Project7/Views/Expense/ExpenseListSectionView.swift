//
//  ExpenseListSectionView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 6/23/24.
//

import SwiftUI
import SwiftData
struct ExpenseListSectionView<Content: View>: View {
    let type: String?
    
    @State var sortOrderSelection: [SortDescriptor<Expense>] = [
        SortDescriptor(\.dateCreated)
    ]
    
    private var sortByName: [SortDescriptor<Expense>] {
        [ SortDescriptor(\.name) ]
    }
    
    private var sortByDateCreated: [SortDescriptor<Expense>] {
        [ SortDescriptor(\.dateCreated) ]
    }
    
    private var sortByAmount: [SortDescriptor<Expense>] {
        [ SortDescriptor(\.amount) ]
    }
    
    @ViewBuilder let content: (String?, [SortDescriptor<Expense>]) -> Content
    
    var body: some View {
        Section {
           content(type, sortOrderSelection)
        } header: {
            HStack {
                if let type = type {
                    Text(type)
                }
                Spacer()
                SortMenu(selection: $sortOrderSelection, options: [
                    SortMenu.Option(title: "Date created", sortDescriptor: sortByDateCreated),
                    SortMenu.Option(title: "Name", sortDescriptor: sortByName),
                    SortMenu.Option(title: "Amount", sortDescriptor: sortByAmount)
                ])
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expense.self, configurations: config)
        return ExpenseListSectionView(type: "Personal") { _, _ in
            ExpenseListSectionContentView(currency: "PHP", type: nil, sort: [
                SortDescriptor(\.dateCreated)
            ])
        }
            .modelContainer(container)
    } catch {
        return Text("Failed to load")
    }

}
