//
//  ContentView.swift
//  11_Project8
//
//  Created by Dexter Ramos on 3/19/24.
//

import SwiftUI


struct ContentView: View {
    
    var astronauts = Bundle.main.decode("astronauts.json")
    
    var astronautArray: [Astronaut] {
        astronauts.values.map { $0.self }
    }
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ForEach(astronautArray, id:\.self) { astronaut in
                    Text(astronaut.name)
                    
                }
            }
//            .frame(maxWidth: .infinity)
            .background(.green)
        }

    }
}

#Preview {
    ContentView()
}
