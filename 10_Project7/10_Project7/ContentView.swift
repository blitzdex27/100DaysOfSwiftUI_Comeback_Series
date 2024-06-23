//
//  ContentView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 3/13/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    
    @Query(
        filter: #Predicate<Expense> { expense in
            expense.type == "Personal"
        }
    ) var personalExpenses: [Expense]
    
    @Query(
        filter: #Predicate<Expense> { expense in
            expense.type == "Business"
        }
    ) var businessExpenses: [Expense]
    
    @State var currency = "USD"
    
    var currencies = ["USD", "PHP"]
    
    
    @State var isShowingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Picker("Currency", selection: $currency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    
                    
                    
                }
                Section("Personal") {
                    ForEach(personalExpenses) {
                        ExpenseView(expense: $0, currencyCode: currency)
                    }
                    .onDelete(perform: handlePersonalExpenseDelete(at:))
                }
                Section("Business") {
                    ForEach(businessExpenses) {
                        ExpenseView(expense: $0, currencyCode: currency)
                    }
                    .onDelete(perform: handleBusinessExpenseDelete(at:))
                }
            }
            .navigationTitle("Expense tracker")
            .toolbar {
                Button("Add expense item", systemImage: "plus") {
                    isShowingAddExpense = true
                }
            }
            .sheet(isPresented: $isShowingAddExpense, content: {
                AddView(currencyCode: currency)
            })
        }
        
    }
    
    func handlePersonalExpenseDelete(at indexSet: IndexSet) {
        for index in indexSet {
            let expense = personalExpenses[index]
            modelContext.delete(expense)
        }
    }
    func handleBusinessExpenseDelete(at indexSet: IndexSet) {
        for index in indexSet {
            let expense = businessExpenses[index]
            modelContext.delete(expense)
        }
    }
}

struct AmountStyleModifier: ViewModifier {
    let amount: Double
    func body(content: Content) -> some View {
        switch amount {
        case ..<10:
            content.foregroundStyle(.green)
        case 10..<100:
            content.foregroundStyle(.orange)
        case 100...:
            content.foregroundStyle(.red)
        default:
            content.foregroundStyle(.secondary)
        }
    }
}

extension Text {
    func applyAmountStyle(for amount: Double) -> some View {
        return modifier(AmountStyleModifier(amount: amount))
    }
}

#Preview {
    ContentView()
}
