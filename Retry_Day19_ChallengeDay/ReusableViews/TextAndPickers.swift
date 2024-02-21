//
//  CustomSections.swift
//  Retry_Day19_ChallengeDay
//
//  Created by Dexter Ramos on 2/18/24.
//

import SwiftUI


struct TextFieldAndPicker<P: PickerStyle>: View {
    // TextField properties
    @Binding private var value: Double
    
    // Picker properties
    @Binding private var selection: String
    
    private let options: [String]
    
    private let customPickerStyle: P
    
    init(value: Binding<Double>, selection: Binding<String>, options: [String], pickerStyle: P) {
        self._value = value
        self._selection = selection
        self.options = options
        self.customPickerStyle = pickerStyle
    }
    
    var body: some View {
        Group {
            textField
            picker
        }
    }
    
    var textField: some View {
        TextField("", value: $value, format: .number)
    }

    var picker: some View {
        Picker("Unit", selection: $selection) {
            ForEach(options, id: \.self) { option in
                Text(option)
            }
        }
        .pickerStyle(customPickerStyle)
    }
}

struct TextAndPicker<P: PickerStyle>: View{
    // TextField properties
    private var value: Double
    
    // Picker properties
    @Binding private var selection: String
    
    private let options: [String]
    
    private let customPickerStyle: P
    
    init(value: Double, selection: Binding<String>, options: [String], pickerStyle: P) {
        self.value = value
        self._selection = selection
        self.options = options
        self.customPickerStyle = pickerStyle
    }
    
    var body: some View {
            textField
            picker
    }
    
    var textField: some View {
        Text(value, format: .number)
    }

    var picker: some View {
        Picker("Unit", selection: $selection) {
            ForEach(options, id: \.self) { option in
                Text(option)
            }
        }
        .pickerStyle(customPickerStyle)
    }
}
