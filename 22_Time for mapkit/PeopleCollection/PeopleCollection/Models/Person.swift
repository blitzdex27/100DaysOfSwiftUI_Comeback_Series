//
//  Person.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/27/24.
//

import Foundation
import SwiftData
import CoreLocation
import MapKit

@Model
class Person: Codable, Identifiable, Comparable {
    
    let id: UUID
    @Attribute(.externalStorage) let imageData: Data
    let name: String
    let latitude: Double?
    let longitude: Double?
    let address: String
    
    var location: CLLocation? {
        guard let latitude, let longitude else {
            return nil
        }
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    init(imageData: Data, name: String, location: CLLocation?, address: String) {
        self.id = UUID()
        self.imageData = imageData
        self.name = name
        self.latitude = location?.coordinate.latitude
        self.longitude = location?.coordinate.longitude
        self.address = address
    }
    
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    enum CodingKeys: CodingKey {
        case id
        case imageData
        case name
        case latitude
        case longitude
        case address
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        imageData = try container.decode(Data.self, forKey: .imageData)
        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        address = try container.decode(String.self, forKey: .address)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        try container.encodeIfPresent(address, forKey: .address)
    }
}
