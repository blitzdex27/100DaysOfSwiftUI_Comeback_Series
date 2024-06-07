//
//  AstronautCell.swift
//  12_Project9
//
//  Created by Dexter Ramos on 6/5/24.
//

import SwiftUI

struct CrewCell: View {
    var crew: Crew
    
    var body: some View {
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

#Preview {
    let crewData = #"""
                    {
                        "name": "schirra",
                        "role": "Commander"
                    }
    """#
    var astronaut = Crew(name: "", role: "")
    let data = Data(crewData.utf8)
    do {
        let decoded = try JSONDecoder().decode(Crew.self, from: data)
        astronaut = decoded
    } catch {
        print(error)
    }

    return CrewCell(crew: astronaut)
}
