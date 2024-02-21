//
//  LengthConverter.swift
//  Retry_Day19_ChallengeDay
//
//  Created by Dexter Ramos on 2/21/24.
//

import Foundation

// Length conversion: users choose meters, kilometers, feet, yards, or miles.
class LengthConverter: DekiUnitConveter {
    let name: String = "Length"
    
    func convert(_ value: Double, unit: Units, to toUnit: Units) -> Double {
        
        let meterValue: Double
        
        switch unit {
        case .meters:
            meterValue = value
        case .kiloMeters:
            meterValue = value * Units.meterFromKilometerRatio
        case .feet:
            meterValue = value * Units.meterFromFeetRatio
        case .yards:
            meterValue = value * Units.meterFromYardsRatio
        case .miles:
            meterValue = value * Units.meterFromMilesRatio
        }
        
        switch toUnit {
        case .meters:
            return meterValue
        case .kiloMeters:
            return meterValue / Units.meterFromKilometerRatio
        case .feet:
            return meterValue / Units.meterFromFeetRatio
        case .yards:
            return meterValue / Units.meterFromYardsRatio
        case .miles:
            return meterValue / Units.meterFromMilesRatio
        }
    }
}

extension LengthConverter {
    enum Units: String, DekiUnit {
        
        case meters = "m"
        case kiloMeters = "km"
        case feet = "ft"
        case yards = "yd"
        case miles = "mi"
        
        static let allUnits: [LengthConverter.Units] = {
            Self.allCases
        }()
        
        static let allUnitsRawValue: [String] = {
            Self.allCases.map({ $0.rawValue })
        }()
        
        // MARK: Conversion ratio
        
        static var meterFromKilometerRatio: Double {
            return 1 / 1000
        }
        
        static var meterFromFeetRatio: Double {
            return 1 / 3.28084
        }
        
        static var meterFromYardsRatio: Double {
            return 1 / 1.09361
        }
        
        static var meterFromMilesRatio: Double {
            return 1 / 0.000621371
        }
    }
}
