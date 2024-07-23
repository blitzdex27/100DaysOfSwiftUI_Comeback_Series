//
//  Location.swift
//  19_Project14_Maps
//
//  Created by Dexter Ramos on 7/23/24.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable, Codable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    static let example = Location(id: UUID(), name: "US", description: "United States", latitude: 56, longitude: 3)
}
