//
//  ContentView.swift
//  13_Milestone_projects-7-8-9
//
//  Created by Dexter  on 6/13/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.habits) private var habits
    @State private var isAddHabitShowing = false
    
    var body: some View {
        ZStack {
            Color.cyan
            NavigationStack {
                
                List {
                    ForEach(habits.items) { habit in
                        HabitCell(habit: habit)
                    }
                    .onDelete(perform: { indexSet in
                        habits.items.remove(atOffsets: indexSet)
                    })
                    .listRowBackground(Color.brown)
                }
                .navigationTitle("Habit Tracker")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button("Add", systemImage: "plus") {
                            isAddHabitShowing.toggle()
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        EditButton()
                    }
                    
                }
                .sheet(isPresented: $isAddHabitShowing, content: {
                    AddHabitView()
                })
                .listItemTint(.blue)
                .scrollContentBackground(.hidden)
                .background(.yellow)
            }
        }
    }
}

#Preview {
    ContentView()
}
