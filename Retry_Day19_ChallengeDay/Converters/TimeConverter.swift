//
//  TimeConverter.swift
//  Retry_Day19_ChallengeDay
//
//  Created by Dexter Ramos on 2/22/24.
//

import Foundation

// Time conversion: users choose seconds, minutes, hours, or days.
class TimeConverter: DekiUnitConveter {
    
    let name: String = "Time"
    
    func convert(_ value: Double, unit: Units, to toUnit: Units) -> Double {
        let secondsEquivalent: Double
        
        switch unit {
        case .seconds:
            secondsEquivalent = value
        case .minutes:
            secondsEquivalent = value * Units.secondToMinuteRatio
        case .hours:
            secondsEquivalent = value * Units.secondToHourRatio
        case .days:
            secondsEquivalent = value * Units.secondToDayRatio
        }
        
        switch toUnit {
        case .seconds:
            return secondsEquivalent
        case .minutes:
            return secondsEquivalent / Units.secondToMinuteRatio
        case .hours:
            return secondsEquivalent / Units.secondToHourRatio
        case .days:
            return secondsEquivalent / Units.secondToDayRatio
        }
    }
}

extension TimeConverter {
    enum Units: String, DekiUnit {
        case seconds = "seconds"
        case minutes = "minutes"
        case hours = "hours"
        case days = "days"
        
        static let allUnits: [TimeConverter.Units] = allCases
        static let allUnitsRawValue: [String] = allCases.map({ $0.rawValue })
        
        static let secondToMinuteRatio: Double = 60
        static let minuteToHourRatio: Double = 60
        static let hourToDayRatio: Double = 24
        
        static let secondToHourRatio: Double = secondToMinuteRatio * minuteToHourRatio
        static let secondToDayRatio: Double = secondToHourRatio * hourToDayRatio
    }
}
