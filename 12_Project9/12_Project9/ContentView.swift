//
//  ContentView.swift
//  12_Project9
//
//  Created by Dexter Ramos on 4/21/24.
//

import SwiftUI


struct ContentView: View {
    
//    let astronauts = Bundle.main.decode("astronauts.json", type: [String: Astronaut].self)
    let missions = Bundle.main.decode("missions.json", type: [Mission].self, dateDecodingStrategy: .formatted(.moonShotDateFormatter))
    
    var missionsArray: [Mission] {
        missions
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid {
                    ForEach(missions) { mission in
                        NavigationLink(destination: <#T##() -> View#>, label: <#T##() -> View#>)
                    }
                }
            }
            .navigationTitle("Moonshot")
            
        }
    }
}



#Preview {
    ContentView()
}
