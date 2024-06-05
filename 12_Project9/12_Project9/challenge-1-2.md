#  <#Title#>

## Content View

```swiftui
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
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        AddView(expense: expenses, currencyCode: currency)
                    } label: {
                        Image(systemName: "plus")
                            .accessibilityHint(.init("Add expense item"))
                    }

                }
//                Button("Add expense item", systemImage: "plus") {
//                    isShowingAddExpense = true
//                }
            }
//            .sheet(isPresented: $isShowingAddExpense, content: {
//                AddView(expense: expenses, currencyCode: currency)
//            })
        }
        
    }
    
    var personalExpenses: some View {
        ForEach(expenses.items) { item in
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
        ForEach(expenses.items) { item in
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
        expenses.items.remove(atOffsets: indexSet)
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
```

## AddView

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
