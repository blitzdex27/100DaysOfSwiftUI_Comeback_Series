//
//  EditLocation+ViewModel.swift
//  19_Project14_Maps
//
//  Created by Dexter Ramos on 7/23/24.
//

import Foundation
import SwiftUI

extension EditLocation {
    @Observable
    class ViewModel {
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var location: Location
        
        var name: String
        var description: String
        
        var loadingState = LoadingState.loading
        var pages = [Page]()
        
        init(location: Location) {
            self.location = location
            self.name = location.name
            self.description = location.description
        }
        
        func makeUpdatedLocationDetails() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            return newLocation
        }
    }
}
