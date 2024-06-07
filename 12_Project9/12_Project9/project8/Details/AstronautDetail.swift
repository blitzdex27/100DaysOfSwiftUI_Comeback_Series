//
//  AstronautDetail.swift
//  12_Project9
//
//  Created by Dexter  on 6/7/24.
//

import SwiftUI

struct AstronautDetail: View {
    
    let name: String
    private let astronaut: Astronaut?
    
    init(name: String) {
        self.name = name
        self.astronaut = Bundle.main.decode("astronauts.json", type: [String: Astronaut].self)[name]
    }
    
    var body: some View {
        Group {
            if let astronaut = astronaut {
                List {
                    Image(name)
                    Section("ID") {
                        Text(astronaut.id)
                    }
                    
                    Section("Name") {
                        Text(astronaut.name)
                    }
                    
                    Section("Background") {
                        Text(astronaut.description)
                    }
                }
                .listStyle(.grouped)
            } else {
                Text("Record not found.")
            }
        }
        .navigationTitle(name.capitalized)
    }
    
}

#Preview {
    AstronautDetail(name: "grissom")
}
