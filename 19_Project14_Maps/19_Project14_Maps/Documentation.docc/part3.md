#  <#Title#>

```
struct Location: Identifiable, Equatable {
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
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(
                latitudeDelta: 10,
                longitudeDelta: 10
            )
        )
    )
    
    @State var locations = [Location]()
    
    @State var addMarker = false

    @State var selectedLocation: Location?
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "start.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    selectedLocation = location
                                }
                        }
              
                            
                    }
           
                }
                .onTapGesture { position in
                    guard addMarker else {
                        return
                    }
                    if let coordinate = proxy.convert(position, from: .local) {
                        let location = Location(id: UUID(), name: "New location", description: "desc", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        locations.append(location)
                        selectedLocation = location
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
            .sheet(item: $selectedLocation) { location in
                EditLocation(location: location) { newLocation in
                    if let index = locations.firstIndex(where: { $0.id == location.id }) {
                        locations[index] = newLocation
                    }
                }
            }
        }
    }
}
```

```
import SwiftUI

struct EditLocation: View {
    @Environment(\.dismiss) private var dismiss
    var location: Location
    let onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.name = location.name
        self.description = location.description
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                Section("Description") {
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Edit location")
            .toolbar(content: {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
 
                    onSave(newLocation)
                    dismiss()
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        EditLocation(location: .example) { _ in
            
        }
    }
}

```
