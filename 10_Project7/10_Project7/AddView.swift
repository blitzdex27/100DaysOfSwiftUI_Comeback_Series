//
//  AddView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 3/15/24.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
//    let expense: Expenses
    let currencyCode: String
    
    @State var name: String = ""
    @State var type: String = "Personal"
    @State var amount: Double = 0.0
    
    let typeOptions = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name:", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(typeOptions, id:\.self) { typeOption in
                        Text(typeOption)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: currencyCode))
            }
            .navigationTitle("Add new expense")
            .toolbar(content: {
                Button("Save") {
                    let item = Expense(name: name, type: type, amount: amount)
//                    expense.items.append(item)
                    modelContext.insert(item)
                    dismiss()
                }
            })
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        var container = try ModelContainer(for: Expense.self, configurations: config)
        return AddView(currencyCode: "USD")
            .modelContainer(for: Expense.self)
    } catch {
        return Text("Failed")
    }
    
}
