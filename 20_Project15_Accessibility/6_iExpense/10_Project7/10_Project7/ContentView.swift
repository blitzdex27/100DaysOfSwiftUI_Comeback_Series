//
//  ContentView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 3/13/24.
//

import SwiftUI
import SwiftData
/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.

 All three of these challenges relate to you upgrade project 7, iExpense:

 1. Start by upgrading it to use SwiftData.
 2. Add a customizable sort order option: by name or by amount.
 3. Add a filter option to show all expenses, just personal expenses, or just business expenses.
 
 Reference:
 https://www.hackingwithswift.com/books/ios-swiftui/swiftdata-wrap-up
 */


struct ContentView: View {
    @Environment(\.appModel) private var appModel
    @Environment(\.modelContext) private var modelContext
    
    @State private var isShowingAddExpense = false
    @State private var selectedFilter = "All"
    
    private var expenseType: String? {
        selectedFilter == "All" ? nil : selectedFilter
    }
    
    var body: some View {
        @Bindable var appModel = appModel
        NavigationStack {
            List {
                HStack {
                    Picker("Currency", selection: $appModel.selectedCurrency) {
                        ForEach(appModel.currencyCodes, id: \.self) { currencyCode in
                            Text(currencyCode)
                        }
                    }
                }
                
                ExpenseListSectionView(type: expenseType) { type, sort in
                    ExpenseListSectionContentView(currency: appModel.selectedCurrency, type: type, sort: sort)
                }
            }
            .navigationTitle("Expense tracker")
            .toolbar {
                Button("Add expense item", systemImage: "plus") {
                    isShowingAddExpense = true
                }
                Menu("Filter") {
                    Picker("", selection: $selectedFilter) {
                        ForEach(appModel.filters, id: \.self) { filter in
                            Text(filter)
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingAddExpense, content: {
                AddView(currencyCode: appModel.selectedCurrency, typeOptions: appModel.expenseTypes)
            })
        }
        
    }
  
}



#Preview {
    ContentView()
}
