//
//  ContentView+ViewModel.swift
//  19_Project14_Maps
//
//  Created by Dexter  on 7/19/24.
//

import Foundation
import MapKit
import LocalAuthentication
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedLocation: Location?
        
        private let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        var isUnlocked = false
        
        private(set) var mapStyle: MapStyle = .standard
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) -> Location {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
            return newLocation
        }
        
        func update(location: Location) {
            guard let selectedLocation else {
                return
            }
            
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = location
                save()
            }
        }
        
        func delete(location: Location) {
            if let index = locations.firstIndex(of: location) {
                locations.remove(at: index)
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate yourself to unlock your places") { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            } else {
                // no bio
            }
                
        }
        
    }
}
