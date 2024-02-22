//
//  TemperatureConverterModel.swift
//  Retry_Day19_ChallengeDay
//
//  Created by Dexter Ramos on 2/18/24.
//

import Foundation

class TemperatureConverter: DekiUnitConveter {
    
    var name: String { "Temperature" }
    
    func convert(_ value: Double, unit: Units, to toUnit: Units) -> Double {
        switch unit {
        case .celsius:
            switch toUnit {
            case .celsius:
                return value
            case .fahrenheit:
                return `Units`.convertToFahrenheit(celsius: value)
            case .kelvin:
                return Units.convertToKelvin(celsius: value)
            }
        case .fahrenheit:
            switch toUnit {
            case .celsius:
                return Units.convertToCelsius(fahrenheit: value)
            case .fahrenheit:
                return value
            case .kelvin:
                return Units.convertToKelvin(fahrenheit: value)
            }
        case .kelvin:
            switch toUnit {
            case .celsius:
                return Units.convertToCelsius(kelvin: value)
            case .fahrenheit:
                return Units.convertToFahrenheit(kelvin: value)
            case .kelvin:
                return value
            }
        }
    }

    
    enum Units: String, DekiUnit {
        
        case celsius = "Celsius"
        case fahrenheit = "Fahrenheit"
        case kelvin = "Kelvin"
        
        
        static let allUnits: [TemperatureConverter.Units] = Self.allCases
        
        static let allUnitsRawValue: [String] = Self.allCases.map({ $0.rawValue })
        
        static func convertToFahrenheit(celsius: Double) -> Double {
            return celsius * (9 / 5.0) + 32
        }
        
        static func convertToFahrenheit(kelvin: Double) -> Double {
            return (kelvin - 273.15) * (9 / 5.0) + 32
        }
        
        static func convertToCelsius(fahrenheit: Double) -> Double {
            return (fahrenheit - 32) * (5 / 9.0)
        }
        
        static func convertToCelsius(kelvin: Double) -> Double {
            return kelvin - 273.15
        }
        
        static func convertToKelvin(celsius: Double) -> Double {
            return celsius + 273.15
        }
        
        static func convertToKelvin(fahrenheit: Double) -> Double {
            let celsius = convertToCelsius(fahrenheit: fahrenheit)
            return convertToKelvin(celsius: celsius)
        }
    }
}
