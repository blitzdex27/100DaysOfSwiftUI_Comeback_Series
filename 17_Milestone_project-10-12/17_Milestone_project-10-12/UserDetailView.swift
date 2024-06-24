//
//  UserDetailView.swift
//  17_Milestone_project-10-12
//
//  Created by Dexter  on 6/24/24.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var isActive: Bool { user.isActive == true }
    
 
    var age: String {
        if let age = user.age {
            String(age)
        } else {
            "-"
        }
    }
    
    var body: some View {
        List {
            Section("Basic information") {
                HStack {
                    Text("Id:")
                    Spacer()
                    Text(user.unWrapped.name)
                        .font(.caption)
                }
                HStack {
                    Text("Status:")
                    Spacer()
                    Text(user.unWrapped.isActive ? "Active" : "Inactive")
                        .foregroundStyle(user.isActive == true ? Color.green : Color.gray)
                }
                
                HStack {
                    Text("Age:")
                    Spacer()
                    Text(user.unWrapped.ageStr)
                }
                
                HStack {
                    Text("Company:")
                    Spacer()
                    Text(user.unWrapped.company)
                }
                
                HStack {
                    Text("Email:")
                    Spacer()
                    Text(user.unWrapped.email)
                }
                
                HStack {
                    Text("Address:")
                    Spacer()
                    Text(user.unWrapped.address)
                }
                
                HStack {
                    Text("About:")
                    Spacer()
                    Text(user.unWrapped.about)
                }
                
                
                HStack {
                    Text("Registered:")
                    Spacer()
                    Text(user.unWrapped.registeredDateStr)
                }
                
                HStack {
                    Text("Tags:")
                    Spacer()
                    ScrollView {
                        HStack{
                            ForEach(user.unWrapped.tags, id: \.self) { tag in
                                Text(tag)
                                    .fixedSize()
                            }
                        }
                            
                    }
                    .frame(width: 100)
                    
                }
            }
            
        }
        .navigationTitle(user.name ?? "Anonymous")
    }
}

#Preview {
//    UserDetailView(user: User())
    let user = User(
        id: UUID().uuidString,
        isActive: true,
        name: "Dexter Ramos",
        age: 31,
        company: "DekiHub",
        email: "wood_butter_27@icloud.com",
        address: "Philippines",
        about: "Just a simple developer",
        registered: .now,
        tags: ["ios developer", "swift developer", "swiftui"],
        friends: [
            Friends(id: UUID().uuidString, name: "Omen"),
            Friends(id: UUID().uuidString, name: "Shinmon"),
            Friends(id: UUID().uuidString, name: "Asimov"),
            Friends(id: UUID().uuidString, name: "Kevin"),
            Friends(id: UUID().uuidString, name: "Grob"),
            Friends(id: UUID().uuidString, name: "Teteng"),
            Friends(id: UUID().uuidString, name: "Unsei"),
            Friends(id: UUID().uuidString, name: "Huweyjay"),
            Friends(id: UUID().uuidString, name: "Suichi"),
            Friends(id: UUID().uuidString, name: "Vanilla"),
        ]
    )
    return NavigationStack {
        UserDetailView(user: user)
    }
}
