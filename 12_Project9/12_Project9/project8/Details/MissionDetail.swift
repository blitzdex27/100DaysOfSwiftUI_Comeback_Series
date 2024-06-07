//
//  MissionDetail.swift
//  12_Project9
//
//  Created by Dexter Ramos on 6/6/24.
//

import SwiftUI

struct MissionDetail: View {
    
    let mission: Mission
    
    
    
    var body: some View {
        List {
            if let launchDate = mission.formattedLaunchDate {
                Section("Launch date") {
                    Text(launchDate)
                }
            }
            
            Section("Details") {
                Text(mission.description)
            }
            
            Section("Crews") {
                
                ScrollView(.horizontal, showsIndicators: false)  {
                    LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(mission.crew, id: \.self.name) { crew in
                            VStack {
                                Image(crew.name)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    .clipShape(.circle)
                                Text(crew.name.capitalized)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                Text(crew.role)
                                    .font(.caption2)
                            }
                        }
                    }
                }
                
                
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(mission.name)
    }
}

#Preview {
    let missionData = #"""
    {
        "id": 7,
        "launchDate": "1968-10-11",
        "crew": [
                  {
                      "name": "schirra",
                      "role": "Commander"
                  },
                  {
                      "name": "eisele",
                      "role": "Command Module Pilot"
                  },
                  {
                      "name": "cunningham",
                      "role": "Lunar Module Pilot"
                  },
                  {
                      "name": "young",
                      "role": "Commander"
                  },
                  {
                      "name": "mattingly",
                      "role": "Command Module Pilotsssasasa"
                  },
                  {
                      "name": "duke",
                      "role": "Lunar Module Pilot"
                  },
                  {
                      "name": "scott",
                      "role": "Commander"
                  },
                  {
                      "name": "worden",
                      "role": "Command module pilot"
                  },
                  {
                      "name": "irwin",
                      "role": "Lunar module pilot"
                  }
        ],
        "description": "Apollo 7 was an October 1968 human spaceflight mission carried out by the United States. It was the first mission in the United States' Apollo program to carry a crew into space. It was also the first U.S. spaceflight to carry astronauts since the flight of Gemini XII in November 1966.\n\nThe AS-204 mission, also known as \"Apollo 1\", was intended to be the first crewed flight of the Apollo program. It was scheduled to launch in February 1967, but a fire in the cabin during a January 1967 test killed the crew.\n\nCrewed flights were then suspended for 21 months, while the cause of the accident was investigated and improvements made to the spacecraft and safety procedures, and uncrewed test flights of the Saturn V rocket and Apollo Lunar Module were made. Apollo 7 fulfilled Apollo 1's mission of testing the Apollo command and service module (CSM) in low Earth orbit."
    }
    """#
    
    var mission = Mission(id: 1, crew: [], description: "4 mission, also known as \"Apollo 1\", was intended to be the first crewed flight of the Apollo program. It was scheduled to launch in February 1967, but a fire in the cabin during a January 1967 test killed the")
    
    let data = Data(missionData.utf8)
    
    do {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.moonShotDateFormatter)
        let decoded = try jsonDecoder.decode(Mission.self, from: data)
        mission = decoded
    } catch {
        print(error)
    }
        
    
    return MissionDetail(mission: mission)
}
