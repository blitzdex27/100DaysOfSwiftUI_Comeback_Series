//
//  AddView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 3/15/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    let expense: Expenses
    let currencyCode: String
    
    @State var name: String = "Name:  "
    @State var type: String = "Personal"
    @State var amount: Double = 0.0
    
    let typeOptions = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
//                TextField("Name:", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(typeOptions, id:\.self) { typeOption in
                        Text(typeOption)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: currencyCode))
            }
//            .navigationTitle("Add new expense")
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expense.items.append(item)
                        dismiss()
                    }
                }

            })
        }
        .navigationBarBackButtonHidden()
        .navigationTitle($name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    AddView(expense: Expenses(), currencyCode: "USD")
}
