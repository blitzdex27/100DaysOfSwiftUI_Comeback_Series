//
//  ContentView.swift
//  19_Project14_Maps
//
//  Created by Dexter  on 7/19/24.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    var body: some View {
        EmptyView()
    }
}

#Preview {
    ContentView()
}
