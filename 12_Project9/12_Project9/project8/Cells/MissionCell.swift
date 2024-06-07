//
//  MissionCell.swift
//  12_Project9
//
//  Created by Dexter Ramos on 6/5/24.
//

import SwiftUI

struct MissionCell: View {
    var mission: Mission
    var body: some View {
        VStack {
            Image(mission.imageName)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, alignment in
                    size * 0.2
                }
            VStack {
                Text(mission.name)
                    .font(.headline)
                Text(mission.formattedLaunchDate ?? "N/A")
                    .font(.caption)
            }
        }
    }
}

#Preview {
    let missionJson = #"""
    {
        "id": 11,
        "launchDate": "1969-07-16",
        "crew": [
            {
                "name": "armstrong",
                "role": "Commander"
            },
            {
                "name": "collins",
                "role": "Command Module Pilot"
            },
            {
                "name": "aldrin",
                "role": "Lunar Module Pilot"
            }
        ],
        "description": "Apollo 11 was the spaceflight that first landed humans on the Moon. Commander Neil Armstrong and lunar module pilot Buzz Aldrin formed the American crew that landed the Apollo Lunar Module Eagle on July 20, 1969, at 20:17 UTC.\n\nArmstrong became the first person to step onto the lunar surface six hours and 39 minutes later on July 21 at 02:56 UTC; Aldrin joined him 19 minutes later. They spent about two and a quarter hours together outside the spacecraft, and they collected 47.5 pounds (21.5 kg) of lunar material to bring back to Earth.\n\nCommand module pilot Michael Collins flew the command module Columbia alone in lunar orbit while they were on the Moon's surface. Armstrong and Aldrin spent 21 hours 31 minutes on the lunar surface at a site they named Tranquility Base before lifting off to rejoin Columbia in lunar orbit."
    }
    """#
    var mission = Mission(id: 1, launchDate: .now, crew: [], description: "")
    let data = Data(missionJson.utf8)
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.moonShotDateFormatter)
        let decoded = try decoder.decode(Mission.self, from: data)
        
        mission = decoded
    } catch {
        print(error)
    }
    return MissionCell(mission: mission)
}
