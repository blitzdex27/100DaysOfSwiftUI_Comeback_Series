//
//  HabitDetailView.swift
//  13_Milestone_projects-7-8-9
//
//  Created by Dexter  on 6/13/24.
//

import SwiftUI

struct HabitDetailView: View {
    @Environment(\.habitStore) private var habitStore
    
    @Bindable var habit: Habit {
        didSet {
            print("tests")
        }
    }
    
    var body: some View {
        VStack {
            progress
            ScrollView {
                Text(habit.description)
                    .multilineTextAlignment(.leading)
            }
            .scrollBounceBehavior(.basedOnSize)
            Spacer()
        }
        .navigationTitle(habit.name)
        .padding()
        .background(.cyan)
        
    }
    
    var progress: some View {
        HStack {
            Spacer()
            decrementButton
            Spacer()
            Text("\(habit.completionCount)")
                .font(.system(size: 100))
            Spacer()
            incrementButton
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var decrementButton: some View {
        Button {
            updateProgress(.decrement(1))
        } label: {
            IncrementDecrementImage(modificationType: .decrement(1))
        }
    }
    
    private var incrementButton: some View {
        Button {
            updateProgress(.increment(1))
        } label: {
            IncrementDecrementImage(modificationType: .increment(1))
        }
    }
    
    func updateProgress(_ modificationType: HabitProgressModification) {
        switch modificationType {
        case .increment(let amount):
            habit.completionCount += amount
        case .decrement(let amount):
            habit.completionCount -= amount
        }
        habitStore.save()
    }
    
    enum Progress {
        case increment
        case decrease
    }
}

struct IncrementDecrementImage: View {
    
    var modificationType: HabitProgressModification
    
    private var style: Style {
        switch modificationType {
        case .increment:
            return .increment
        case .decrement:
            return .decrement
        }
    }
    
    var body: some View {
        Image(systemName: style.sysImageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50)
            .tint(style.tint)
    }
    
    enum Style {
        case increment
        case decrement
        
        var sysImageName: String {
            switch self {
            case .increment:
                return "arrow.forward.circle.fill"
            case .decrement:
                return "arrow.backward.circle.fill"
            }
        }
        
        var tint: Color {
            switch self {
            case .increment:
                return .green
            case .decrement:
                return .red
            }
        }
    }
}

#Preview {
    let habit = Habit(name: "test", description: "adasd asdkja shdkjasd hbaskj ,dmhabsijkd ,amsn")
    return HabitDetailView(habit: habit)
}
