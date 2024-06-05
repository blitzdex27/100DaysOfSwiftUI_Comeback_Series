//
//  AstronautCell.swift
//  12_Project9
//
//  Created by Dexter Ramos on 6/5/24.
//

import SwiftUI

struct AstronautCell: View {
    var astronaut: Astronaut
    
    var body: some View {
        VStack {
            Image(astronaut.id)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(.circle)
            Text(astronaut.name)
        }
        
    }
}

#Preview {
    let name = #"""
        {
            "id": "grissom",
            "name": "Virgil I. \"Gus\" Grissom",
            "description": "Virgil Ivan \"Gus\" Grissom (April 3, 1926 – January 27, 1967) was one of the seven original National Aeronautics and Space Administration's Project Mercury astronauts, and the first of the Mercury Seven to die. He was also a Project Gemini and an Apollo program astronaut. Grissom was the second American to fly in space, and the first member of the NASA Astronaut Corps to fly in space twice.\n\nIn addition, Grissom was a World War II and Korean War veteran, U.S. Air Force test pilot, and a mechanical engineer. He was a recipient of the Distinguished Flying Cross, and the Air Medal with an oak leaf cluster, a two-time recipient of the NASA Distinguished Service Medal, and, posthumously, the Congressional Space Medal of Honor."
        }
    """#
    var astronaut = Astronaut(id: "schweickart", name: "testname", description: "testststs")
    let data = Data(name.utf8)
    do {
        let decoded = try JSONDecoder().decode(Astronaut.self, from: data)
        astronaut = decoded
    } catch {
        print(error)
    }

    return AstronautCell(astronaut: astronaut)
}
