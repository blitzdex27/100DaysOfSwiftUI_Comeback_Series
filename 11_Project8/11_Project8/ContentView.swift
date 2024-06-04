//
//  ContentView.swift
//  11_Project8
//
//  Created by Dexter Ramos on 3/19/24.
//

import SwiftUI


struct ContentView: View {
    
    var astronauts = Bundle.main.decode("astranauts.json")
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ForEach(astronauts.values, id:\.self) {
                    Text($0.name)
                    
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
