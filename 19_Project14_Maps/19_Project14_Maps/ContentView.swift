//
//  ContentView.swift
//  19_Project14_Maps
//
//  Created by Dexter  on 7/19/24.
//

import SwiftUI
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

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 14.115286, longitude: 120.962112),
            span: MKCoordinateSpan(
                latitudeDelta: 10,
                longitudeDelta: 10
            )
        )
    )

    
    @State var addMarker = false
    
    var body: some View {
        if viewModel.isUnlocked {
            content
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
    
    var content: some View {
        NavigationStack {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "start.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedLocation = location
                                }
                        }
              
                            
                    }
           
                }.mapStyle(<#T##value: MapStyle##MapStyle#>)
                .onTapGesture { position in
                    guard addMarker else {
                        return
                    }
                    if let coordinate = proxy.convert(position, from: .local) {
                        let tappedLocation = viewModel.addLocation(at: coordinate)
                        viewModel.selectedLocation = tappedLocation
                    }
                }
                
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem {
                    Button(addMarker ? "Done": "Add marker", systemImage: addMarker ? "checkmark": "plus") {
                        addMarker.toggle()
                    }
                }
            })
            .sheet(item: $viewModel.selectedLocation) { location in
                EditLocation(location: location, onSave: viewModel.update, onDelete: viewModel.delete)
            }
        }
    }
}

#Preview {
    ContentView()
}
