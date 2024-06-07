//
//  MoonShotView.swift
//  12_Project9
//
//  Created by Dexter  on 6/7/24.
//

import SwiftUI

struct MoonShotView: View {

    let missions = Bundle.main.decode("missions.json", type: [Mission].self, dateDecodingStrategy: .formatted(.moonShotDateFormatter))
    
    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var missionsArray: [Mission] {
        missions
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink(value: mission) {
                            MissionCell(mission: mission)
                        }
//                        NavigationLink {
//                            MissionDetail(mission: mission)
//                        } label: {
//                            MissionCell(mission: mission)
//                        }
                    }
                    .frame(maxHeight: 100)
                }
            }
            .navigationTitle("Moonshot")
            .navigationDestination(for: Mission.self) { mission in
                MissionDetail(mission: mission)
            }
        }
    }
}

#Preview {
    MoonShotView()
}
