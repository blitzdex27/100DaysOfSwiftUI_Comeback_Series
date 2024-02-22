//
//  UnitConveter.swift
//  Retry_Day19_ChallengeDay
//
//  Created by Dexter Ramos on 2/21/24.
//

import Foundation

protocol DekiUnitConveter {
    associatedtype Unit: DekiUnit
    var name: String { get }
    func convert(_ value: Double, unit: Unit, to toUnit: Unit) -> Double
}

protocol DekiUnit: RawRepresentable, CaseIterable {
    static var allUnits: [Self] { get }
    static var allUnitsRawValue: [RawValue] { get }
}


