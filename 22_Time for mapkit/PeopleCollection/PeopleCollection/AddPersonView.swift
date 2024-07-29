//
//  AddPersonView.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/27/24.
//

import SwiftUI
import MapKit

struct AddPersonView: View {
    @Environment(\.dismiss) private var dismiss
    let imageData: Data
    let onAdd: (_ imagedata: Data, _ name: String, _ location: CLLocation?, _ address: String) -> Void
    
    @State var showingAlert = false
    @State var alertTitle = "Empty name field"
    @State var currentLocation: CLLocation?
    @State var name = ""
    @State var address = "-"
    
    @State private var progressValue = 0.0
    @State private var progressTotal = 10.0
    
    private let locationFetcher = LocationFetcher()
    var body: some View {
        NavigationStack {
            VStack {
                Image(data: imageData)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack {
                    if let currentLocation {
                        LocationPinnedView(location: currentLocation)
                    } else {
                        ProgressView("Fetching location...", value: progressValue, total: progressTotal)
                    }
                }
                .frame(maxHeight: 100)
                TextField("Input name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    
                Spacer()
            }
            .padding()
            .navigationTitle("Add Person")
            .toolbar(content: {
                ToolbarItem {
                    Button("Save", systemImage: "checkmark") {
                        if name.isEmpty {
                            showingAlert = true
                            return
                        }
                        onAdd(imageData, name, currentLocation, address)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            })
            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") { }
            }
            .onAppear(perform: getCurrentLocation)
        }
        
    }
    func getCurrentLocation() {
        
        locationFetcher.setProgress { value, total in
            progressValue = value
            progressTotal = total
        }
        Task {
            do {
                let (location, address) = try await locationFetcher.getLocation()
                currentLocation = location
                if let address {
                    self.address = address
                }
            } catch {
                print(error)
            }
            
        }
    }
}

#Preview {
    AddPersonView(imageData: Data()) { imagedata, name, location, address in
        
    }
}
