//
//  PersonDetailView.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/28/24.
//

import SwiftUI
import CoreLocation

struct PersonDetailView: View {
    let person: Person
    var body: some View {
        ScrollView {
            VStack {
                Image(data: person.imageData)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
        .navigationTitle(person.name)
    }
}

#Preview {
    PersonDetailView(person: Person(imageData: Data(), name: "", location: CLLocation(latitude: 1, longitude: 1), address: "-"))
}
