//
//  ContentView.swift
//  17_Milestone_project-10-12
//
//  Created by Dexter  on 6/24/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = []
    
    
    
    var body: some View {
        NavigationStack {
            
           
                List(users) { user in
                    HStack {
                        NavigationLink(value: user) {
                            Text(user.name ?? "Anonymous")
                            Spacer()
                            Text(user.isActive == true ? "Active" : "Inactive")
                                .foregroundStyle(user.isActive == true ? Color.green : Color.gray)
                        }
                    }
                }
                .onAppear(perform: getUsersIfNeeded)
                .navigationTitle("Users")
                .scrollContentBackground(.hidden)
                .background(.orange)
                .navigationDestination(for: User.self) { user in
                    <#code#>
                }
        }
    }
    
    private func getUsersIfNeeded() {
        if users.isEmpty {
            Task {
                users = await APIService.getUsers()
            }
        }
    }
}

#Preview {
    ContentView()
}
