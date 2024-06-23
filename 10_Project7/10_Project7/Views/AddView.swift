//
//  AddView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 3/15/24.
//

import SwiftUI
import SwiftData

struct AddView: View {
    
    let currencyCode: String
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    
    let typeOptions: [String]// = ["Personal", "Business"]
    
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
        let container = try ModelContainer(for: Expense.self, configurations: config)
        let appModel = AppModel.makeDummy()
        return AddView(currencyCode: "USD", typeOptions: appModel.expenseTypes)
            .modelContainer(container)
    } catch {
        return Text("Failed")
    }
    
}
