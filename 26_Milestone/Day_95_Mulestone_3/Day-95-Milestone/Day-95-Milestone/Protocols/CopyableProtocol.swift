//
//  CopyableProtocol.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/19/25.
//

protocol CopyableProtocol {
    associatedtype SELF
    func copy() -> SELF
}
