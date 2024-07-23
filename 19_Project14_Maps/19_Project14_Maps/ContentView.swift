//
//  ContentView.swift
//  19_Project14_Maps
//
//  Created by Dexter  on 7/19/24.
//

import SwiftUI
import MapKit

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
           
                }.mapStyle(viewModel.mapStyle.mapStyle)
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
                ToolbarItem {
                    Picker("Map Style", selection: $viewModel.mapStyle) {
                        ForEach(viewModel.mapStyles, id: \.self) { mapStyle in
                            Text(mapStyle.name)
                                
                        }
                    }
                }

            })
            .sheet(item: $viewModel.selectedLocation) { location in
                EditLocation(location: location, onSave: viewModel.update, onDelete: viewModel.delete)
            }
            .alert("Authentication Error", isPresented: $viewModel.showingAuthErrorAlert) {
                Button("Ok") { }
            } message: {
                Text(viewModel.authError ?? "Unknown error")
            }
        }
    }
}

#Preview {
    ContentView()
}
