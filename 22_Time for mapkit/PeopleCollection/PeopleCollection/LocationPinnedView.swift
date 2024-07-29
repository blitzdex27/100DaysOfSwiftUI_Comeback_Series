//
//  LocationPinnedView.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/28/24.
//

import SwiftUI
import MapKit

struct LocationPinnedView: View {
    let location: CLLocation
    
    var position: MapCameraPosition {
        MapCameraPosition.region(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan.init()))
    }
    var body: some View {
        Map(initialPosition: position) {
            Marker("New Person <3", coordinate: location.coordinate)
            
        }
    }
}

//#Preview {
//    LocationPinnedView()
//}
