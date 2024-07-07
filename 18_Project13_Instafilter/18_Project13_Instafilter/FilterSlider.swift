//
//  FilterSlider.swift
//  18_Project13_Instafilter
//
//  Created by Dexter Ramos on 7/7/24.
//

import SwiftUI

struct FilterSlider: View {
    
    @Binding var selection: Double
    let name: String
    let onChange: () -> Void
    var limits: ClosedRange<Double> = 0...1
    var body: some View {
        HStack {
            Text(name)
            Slider(value: $selection, in: limits)
                .onChange(of: selection, onChange)
        }
    }
}

#Preview {
    @State var selection = 0.5
    
    return FilterSlider(selection: $selection, name: "Intensity") {
        
    }
}
