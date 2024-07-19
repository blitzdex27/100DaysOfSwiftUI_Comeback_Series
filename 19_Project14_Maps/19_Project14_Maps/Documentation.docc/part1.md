#  Integrating MapKit with SwiftUI

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2DMake(51.507222, -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    var body: some View {
        VStack {
            MapReader(content: { proxy in
                Map(position: $position) {
                    ForEach(locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Text(location.name)
                                .font(.headline)
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(.capsule)
                        }
                        .annotationTitles(.hidden)
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        print(coordinate)
                    }
                }
            })
            
            .onMapCameraChange {
                print("position \(position)")
            }
            HStack {
                Button("Paris") {
                    withAnimation {
                        position = MapCameraPosition.region(
                            MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                        )
                    }
                    
                }
                Button("Tokyo") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                    )
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
