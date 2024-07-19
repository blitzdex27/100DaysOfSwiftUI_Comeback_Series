//
//  ContentView+ViewModel.swift
//  19_Project14_Maps
//
//  Created by Dexter  on 7/19/24.
//

import Foundation
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations = [Location]()
        var selectedLocation: Location?
        
        func addLocation(at point: CLLocationCoordinate2D) -> Location {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            return newLocation
        }
        
        func update(location: Location) {
            guard let selectedLocation else {
                return
            }
            
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = location
            }
        }
    }
}
