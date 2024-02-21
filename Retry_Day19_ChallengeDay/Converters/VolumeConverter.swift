//
//  VolumeConverter.swift
//  Retry_Day19_ChallengeDay
//
//  Created by Dexter Ramos on 2/22/24.
//

import Foundation

// Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
class VolumeConverter: DekiUnitConveter {
    
    let name: String = "Volume"
    func convert(_ value: Double, unit: Units, to toUnit: Units) -> Double {
        
        let gallonValue: Double
        
        switch unit {
        case .milliLiters:
            gallonValue = value * Units.gallonToMilliLitersRatio
        case .liters:
            gallonValue = value * Units.gallonToLiterRatio
        case .cups:
            gallonValue = value * Units.gallonToCupRatio
        case .pints:
            gallonValue = value * Units.gallonToPintRatio
        case .gallons:
            gallonValue = value
        }
        
        switch toUnit {
        case .milliLiters:
            return gallonValue / Units.gallonToMilliLitersRatio
        case .liters:
            return gallonValue / Units.gallonToLiterRatio
        case .cups:
            return gallonValue / Units.gallonToCupRatio
        case .pints:
            return gallonValue / Units.gallonToPintRatio
        case .gallons:
            return gallonValue
        }
    }
}

extension VolumeConverter {
    enum Units: String, DekiUnit {
        case milliLiters = "mL"
        case liters = "L"
        case cups = "cups"
        case pints = "pints"
        case gallons = "gallons"
        
        static let allUnits: [VolumeConverter.Units] = allCases
        
        static let allUnitsRawValue: [String] = allCases.map({ $0.rawValue })
        
        static let milliLitersToLitersRatio: Double = 1000
        static let gallonToCupRatio: Double = 1 / 16
        static let gallonToPintRatio: Double = 1 / 8
        static let gallonToLiterRatio: Double = 1 / 3.78541178
        static let gallonToMilliLitersRatio: Double = gallonToLiterRatio / milliLitersToLitersRatio
    }
}
