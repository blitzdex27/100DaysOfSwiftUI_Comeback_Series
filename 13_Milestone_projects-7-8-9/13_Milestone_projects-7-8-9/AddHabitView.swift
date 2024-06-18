//
//  AddHabitView.swift
//  13_Milestone_projects-7-8-9
//
//  Created by Dexter  on 6/13/24.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.habits) private var habits
    @State private var name: String = ""
    @State private var description: String = ""
    var body: some View {
        NavigationStack {
            List {
                Section("Name") {
                    TextField(text: $name, prompt: Text("Enter habit name")) {
                    }
                }
                Section("Description") {
                    TextEditor(text: $description)
                }
            }
            .background(.green)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                        let habit = Habit(name: name, description: description)
                        habits.items.append(habit)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add new habit")
        }
    }
}

#Preview {
    AddHabitView()
}
