//
//  ContentView.swift
//  WeSplit_retry3
//
//  Created by Dexter Ramos on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var billAmount: Double = 0.0
    
    var tipPercentages = [0.1, 0.15, 0.2, 0.25, 0.3]
    
    var numberOfPeopleOptions = [1, 2, 3, 4]
    
    @State var selectedNumberOfPeopleOption = 1
    
    @State var selectedTipPercentage = 0.2
    
    var amountPerPerson: Double {
        totalAmount / Double(selectedNumberOfPeopleOption)
    }
    
    var totalAmount: Double {
        billAmount * (1 + selectedTipPercentage)
    }

    var body: some View {
        NavigationStack {
            Form {
                AmountTextFieldSection(amount: $billAmount)
                
                Section {
                    Picker("Number of People", selection: $selectedNumberOfPeopleOption) {
                        ForEach(numberOfPeopleOptions, id: \.self) { numberOfPeopleOption in

                            Text("\(numberOfPeopleOption)")
                            
                        }
                    }
                    Picker("", selection: $selectedTipPercentage) {
                        ForEach(tipPercentages, id: \.self) { tipPercentage in
                            Text(tipPercentage, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Number of people and tip percentage")
                }

                
                AmountSection(header: "Amount per person", value: amountPerPerson)
                AmountSection(header: "Total amount", value: totalAmount)
                
            }
            .navigationTitle("WeSplit")
        }
        
    }
}

struct AmountSection: View {
    let header: String
    let value: Double
    
    var body: some View {
        Section {
            Text(value, format: .currency(code: "PHP"))
        } header: {
            Text(header)
        }
    }
}

struct AmountTextFieldSection: View {
    
    @Binding var amount: Double
    
    var body: some View {
        TextField("", value: $amount, format: .currency(code: "PHP"))
    }
    
    init(amount: Binding<Double>) {
        self._amount = amount
    }
}

#Preview {
    ContentView()
}
