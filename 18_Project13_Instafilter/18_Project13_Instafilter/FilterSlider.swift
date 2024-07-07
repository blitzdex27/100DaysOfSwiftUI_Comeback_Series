//
//  FilterSlider.swift
//  18_Project13_Instafilter
//
//  Created by Dexter Ramos on 7/7/24.
//

import SwiftUI

struct FilterSlider: View {
    
    typealias OnChangeClosure = (_ value: Double, _ valueVector: CIVector, _ filterInputKey: String, _ isVector: Bool) -> Void
    
    var isVector: Bool
    let onChange: OnChangeClosure
    var name: String
    let filterInputKey: String
    let filter: CIFilter
    
    
    // Double
    @State var selection: Double = 0
    var maxValue: Double = 1
    
    // CIVector
    @State var selectionX: Double = 0
    @State var selectionY: Double = 0
    var maxValueX: Double = 1
    var maxValueY: Double = 1
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
          
                if !isVector {
                    Slider(value: $selection, in: 0...maxValue)
                        .onChange(of: selection) { _, newValue in
                            onChange(newValue, CIVector(x: selectionX, y: selectionY), filterInputKey, false)
                        }
                } else {
                    VStack {
                        Text("X")
                        Slider(value: $selectionX, in: 0...maxValueX)
                            .onChange(of: selectionX) { _, newValue in
                                onChange(newValue, CIVector(x: selectionX, y: selectionY), filterInputKey, true)
                            }
                        VStack {
                            Text("Current: \(selectionX)")
                            Text("Max: \(maxValueX)")
                        }
                        
                    }
                    .font(.caption)
                    VStack {
                        Text("Y")
                        Slider(value: $selectionY, in: 0...maxValueY)
                            .onChange(of: selectionY) { _, newValue in
                                onChange(newValue, CIVector(x: selectionX, y: selectionY), filterInputKey, true)
                            }
                        VStack {
                            Text("Current: \(selectionY)")
                            Text("Max: \(maxValueY)")
                        }
                        
                    }
                    .font(.caption)
                }
                    
            }
            HStack {
                Text("Current: \(selection)")
                Spacer()
                Text("Max: \(maxValue)")
            }
            .font(.caption)
        }
    }
    
    init(filter: CIFilter, name: String, filterInputKey: String, onChange: @escaping OnChangeClosure) {
        isVector = false
        self.filter = filter
        self.name = name
        self.filterInputKey = filterInputKey
        
        let inputAttributes = filter.attributes
        if let inputKey = inputAttributes[filterInputKey] as? [String: Any] {
            
            if let name = inputKey[kCIAttributeDisplayName] as? String {
                self.name = name
            }
            
            let attributeClass = inputKey[kCIAttributeClass] as? String
            
            switch attributeClass {
            case "NSNumber":
                isVector = false
                if let defaultValue = inputKey[kCIAttributeDefault] as? Double {
                    self.selection = defaultValue
                }
                if let sliderMax = inputKey[kCIAttributeSliderMax] as? Double {
                    self.maxValue = sliderMax
                }
            case "CIVector":
                if let defaultValue = inputKey[kCIAttributeDefault] as? CIVector {
                    selectionX = defaultValue.cgPointValue.x
                    selectionY = defaultValue.cgPointValue.y
                    maxValueX = defaultValue.cgPointValue.x * 100
                    maxValueY = defaultValue.cgPointValue.y * 100
                }
                isVector = true
            default:
                break
            }
            

        }
        self.onChange = onChange
    }
}

#Preview {
    FilterSlider(filter: CIFilter.kaleidoscope(), name: kCIInputIntensityKey, filterInputKey: kCIInputIntensityKey) { value, inputKey, _, _ in
        
    }
}
