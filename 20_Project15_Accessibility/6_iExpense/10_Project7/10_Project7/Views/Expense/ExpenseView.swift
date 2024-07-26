//
//  ExpenseView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 6/23/24.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    let expense: Expense
    
    var currencyCode: String
    
    var body: some View {
        HStack {
            Text(expense.name)
            Spacer()
            Text(expense.amount, format:.currency(code: currencyCode))
                .applyAmountStyle(for: expense.amount)
        }
        .accessibilityElement()
        .accessibilityLabel("\(expense.name) \(expense.amount)")
        .accessibilityHint(expense.type)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expense.self, configurations: config)
        let expense = Expense(name: "Grocery", type: "Cash", amount: 100)
        return ExpenseView(expense: expense, currencyCode: "PHP")
            .modelContainer(container)
    } catch {
        return Text("Failed to load")
    }
    
}
