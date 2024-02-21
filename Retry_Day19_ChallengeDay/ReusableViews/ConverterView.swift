//
//  Converter.swift
//  Retry_Day19_ChallengeDay
//
//  Created by Dexter Ramos on 2/21/24.
//

import SwiftUI

struct ConverterView<Converter: DekiUnitConveter>: View where Converter.Unit.RawValue == String {
    
    private let converter: Converter
    
    private let units: [String] = Converter.Unit.allUnitsRawValue
    
    // INPUT
    
    @State private var input: Double = 0
    
    @State var inputUnitString: String = Converter.Unit.allUnitsRawValue[0]
    
    private var inputUnit: Converter.Unit? {
        return Converter.Unit(rawValue: inputUnitString)
    }

    
    // OUTPUT
    
    private var output: Double {
        let inputUnit = inputUnit ?? Converter.Unit.allUnits[0]
        let outputUnit = outputUnit ?? Converter.Unit.allUnits[0]
        return converter.convert(input, unit: inputUnit, to: outputUnit)
    }
    
    @State private var outputUnitString: String = Converter.Unit.allUnitsRawValue[0]

    private var outputUnit: Converter.Unit? {
        return Converter.Unit(rawValue: outputUnitString)
    }
    
    init(converter: Converter) {
        self.converter = converter
    }

    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextFieldAndPicker(
                        value: $input,
                        selection: $inputUnitString,
                        options: units,
                        pickerStyle: .segmented)
                } header: {
                    Text("Input")
                }
                
                Section {
                    TextAndPicker(
                        value: output,
                        selection: $outputUnitString,
                        options: units,
                        pickerStyle: .segmented)

                } header: {
                    Text("Output")
                }
                
            }
            .navigationTitle("\(converter.name) Converter")
        }
    }
}

#Preview {
    ConverterView(converter: TemperatureConverter())
}
