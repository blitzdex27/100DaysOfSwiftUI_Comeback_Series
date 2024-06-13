//
//  HabitCell.swift
//  13_Milestone_projects-7-8-9
//
//  Created by Dexter  on 6/13/24.
//

import SwiftUI

struct HabitCell: View {
    
    @Bindable var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    var body: some View {
        NavigationLink(value: habit) {
            VStack(alignment:.leading) {
                Text(habit.id)
                    .font(.caption)
                HStack {
                    Text(habit.name)
                    Spacer()
                    Text("Progress: \(habit.completionCount)")
                }
                
            }
        }
        .navigationDestination(for: Habit.self) { habit in
            @Bindable var habit = habit
            HabitDetailView(habit: habit)
        }
        
    }
}

#Preview {
    HabitCell(habit: .init(name: "Test", description: "test"))
}
