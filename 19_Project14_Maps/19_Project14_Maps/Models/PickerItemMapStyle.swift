//
//  PickerItemMapStyle.swift
//  19_Project14_Maps
//
//  Created by Dexter Ramos on 7/23/24.
//

import Foundation
import MapKit
import SwiftUI

struct PickerItemMapStyle {
    let name: String
    let mapStyle: MapStyle
}

extension PickerItemMapStyle: Hashable {
    static func == (lhs: PickerItemMapStyle, rhs: PickerItemMapStyle) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
