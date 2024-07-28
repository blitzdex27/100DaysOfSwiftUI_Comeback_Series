//
//  Person.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/27/24.
//

import Foundation

struct Person: Codable, Identifiable, Comparable {
    
    let id: UUID
    let imageData: Data
    let name: String
    
    init(imageData: Data, name: String) {
        self.id = UUID()
        self.imageData = imageData
        self.name = name
    }
    
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
