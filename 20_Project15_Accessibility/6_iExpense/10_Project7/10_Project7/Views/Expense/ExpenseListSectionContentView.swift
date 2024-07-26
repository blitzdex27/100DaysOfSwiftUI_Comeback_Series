//
//  ExpenseListSectionContentView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 6/23/24.
//

import SwiftUI
import SwiftData

struct ExpenseListSectionContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    let currency: String
    
    @Query private var expenses: [Expense]
    
    var body: some View {
        if expenses.isEmpty {
            Text("No expense data to show...")
        } else {
            ForEach(expenses) { expense in
                ExpenseView(expense: expense, currencyCode: currency)
            }
            .onDelete(perform: handleDelete(at:))
        }
        
    }
    
    func handleDelete(at indexSet: IndexSet) {
        for index in indexSet {
            let expense = expenses[index]
            modelContext.delete(expense)
        }
    }
    
    init(currency: String, type: String?, sort: [SortDescriptor<Expense>]) {
        self.currency = currency
        
        let predicate: Predicate<Expense>?
        if let type = type {
            predicate = #Predicate<Expense> { expense in
                expense.type == type
            }
        } else {
            predicate = nil
        }
        
        _expenses = Query(filter: predicate, sort: sort, animation: .bouncy)
    }
}

#Preview {
    ExpenseListSectionContentView(currency: "PHP", type: "Personal", sort: [SortDescriptor(\.dateCreated)])
        .modelContainer(for: Expense.self)
}
