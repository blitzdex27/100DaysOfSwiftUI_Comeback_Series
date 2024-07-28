//
//  Person.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/27/24.
//

import Foundation
import SwiftData

@Model
class Person: Codable, Identifiable, Comparable {
    
    let id: UUID
    @Attribute(.externalStorage) let imageData: Data
    let name: String
    
    init(imageData: Data, name: String) {
        self.id = UUID()
        self.imageData = imageData
        self.name = name
    }
    
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    enum CodingKeys: CodingKey {
        case id
        case imageData
        case name
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        imageData = try container.decode(Data.self, forKey: .imageData)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(name, forKey: .name)
    }
}
