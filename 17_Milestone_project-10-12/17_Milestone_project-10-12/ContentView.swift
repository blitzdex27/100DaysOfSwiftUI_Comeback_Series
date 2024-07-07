//
//  ContentView.swift
//  17_Milestone_project-10-12
//
//  Created by Dexter  on 6/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var users: [User]
    
    var body: some View {
        NavigationStack {
            
            
            List(users) { user in
                
                NavigationLink(value: user) {
                    HStack {
                        Text(user.name ?? "Anonymous")
                        Spacer()
                        Text(user.isActive == true ? "Active" : "Inactive")
                            .foregroundStyle(user.isActive == true ? Color.green : Color.gray)
                    }
                }
            }
            .onAppear(perform: getUsersIfNeeded)
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
    }
    
    private func getUsersIfNeeded() {
        if users.isEmpty {
            Task {
                
                print(modelContext.autosaveEnabled)
                do {
                    
                    let users = await APIService.getUsers()
                    
                    try modelContext.transaction {
                        for user in users {
                            modelContext.insert(user)
                        }
                    }
    
                    print("users added")
                } catch {
                    print("Unable to fetch users")
                }
                
            }
        }
    }
    
    
}


#Preview {
    ContentView()
}
