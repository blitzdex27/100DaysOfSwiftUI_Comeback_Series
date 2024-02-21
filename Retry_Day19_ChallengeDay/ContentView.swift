//
//  ContentView.swift
//  Retry_Day19_ChallengeDay
//
//  Created by Dexter Ramos on 2/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Temperature") {
                ConverterView(converter: TemperatureConverter())
            }
            NavigationLink("Length") {
                ConverterView(converter: LengthConverter())
            }
            NavigationLink("Time") {
                ConverterView(converter: TimeConverter())
            }
            NavigationLink("Volume") {
                ConverterView(converter: VolumeConverter())
            }
            
            .navigationTitle("Deki Converters")
        }
        
    }
}

#Preview {
    ContentView()
}
