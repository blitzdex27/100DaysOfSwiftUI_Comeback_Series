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
    
    @Query var expenses: [Expense]
    
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
                    personalExpenses
                }
                Section("Business") {
                    businessExpenses
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
    
    var personalExpenses: some View {
        ForEach(expenses) { item in
            if item.type == "Personal"  {
                HStack {
                    Text(item.name)
                    Spacer()
                    Text(item.amount, format:.currency(code: currency))
                        .applyAmountStyle(for: item.amount)
                }
            }
            
        }
        .onDelete(perform: handleDelete(at:))
    }
    var businessExpenses: some View {
        ForEach(expenses) { item in
            if item.type == "Business"  {
                HStack {
                    Text(item.name)
                    Spacer()
                    Text(item.amount, format:.currency(code: currency))
                        .applyAmountStyle(for: item.amount)
                }
            }
        }
        .onDelete(perform: handleDelete(at:))
    }
    
    
    func handleDelete(at indexSet: IndexSet) {
//        expenses.remove(atOffsets: indexSet)
        for index in indexSet {
            let expense = expenses[index]
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
