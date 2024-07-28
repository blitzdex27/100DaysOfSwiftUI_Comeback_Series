//
//  PersonDetailView.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/28/24.
//

import SwiftUI

struct PersonDetailView: View {
    let person: Person
    var body: some View {
        ScrollView {
            VStack {
                Image(data: person.imageData)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .navigationTitle(person.name)
    }
}

#Preview {
    PersonDetailView(person: Person(imageData: Data(), name: ""))
}
