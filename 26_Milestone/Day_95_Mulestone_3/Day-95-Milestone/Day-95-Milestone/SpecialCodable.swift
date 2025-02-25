//
//  SpecialCodable.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/21/25.
//

protocol SpecialCodable {
    associatedtype CodableType = Codable
    associatedtype SELF = Self
    func toCodable() -> CodableType
    static func fromCodable(_ codable: CodableType) -> SELF
}
