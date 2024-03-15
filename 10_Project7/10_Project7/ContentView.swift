//
//  ContentView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 3/13/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items: [ExpenseItem] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    init() {
        if let savedItems =  UserDefaults.standard.data(forKey: "items"),
           let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems)
        {
            items = decodedItems
            return
        }
        items = []
    }
}

struct ContentView: View {

    @State var expenses = Expenses()
    
    @State var isShowingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text(item.amount, format:.currency(code: "PHP"))
                    }
                }
                .onDelete(perform: handleDelete(at:))
            }
            .navigationTitle("Expense tracker")
            .toolbar {
                Button("Add expense item", systemImage: "plus") {
                    isShowingAddExpense = true
                }
            }
            .sheet(isPresented: $isShowingAddExpense, content: {
                AddView(expense: expenses)
            })
        }
        
    }
    
    func handleDelete(at indexSet: IndexSet) {
        expenses.items.remove(atOffsets: indexSet)
    }
}

#Preview {
    ContentView()
}
