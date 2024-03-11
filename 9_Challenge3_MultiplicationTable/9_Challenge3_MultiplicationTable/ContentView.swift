//
//  ContentView.swift
//  9_Challenge3_MultiplicationTable
//
//  Created by Dexter Ramos on 3/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTable: String? = nil
    
    @State private var questionCount: Int? = nil
    
    @State private var isQuestionsPresented = false
    
    @State var points = 0
    
    private var questionCountChoices = [5, 15, 20]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let selectedTable = selectedTable,
                   let questionCount = questionCount
                {
                    
                    QuestionsView(game: .init(table: selectedTable, questionCount: questionCount), didTapGobackAction: { points in
                        withAnimation {
                            self.points += points
                            self.questionCount = nil
                            self.selectedTable = nil
                        }
                    
                    })
                    
                    .transition(.scale)
                    .navigationTitle("Questions")
                    
                    
                } else if selectedTable != nil {
                    SelectHowManyQuestionsView(choices: questionCountChoices) { questionCount in
                        withAnimation {
                            self.questionCount = questionCount
                        }
                    }
                    .transition(.scale)
                    .navigationTitle("No. of questions")
                } else {
                    TableSelectionView { table in
                        withAnimation {
                            selectedTable = "x\(table.rawValue)"
                        }
                        
                    }
                    
                    .transition(.scale)
                    .navigationTitle("Choose a table")
                }
                
            }
            .toolbar(content: {
                Text("Accumulated points: \(points)")
            })
        }
    }
    
    
    
}

#Preview {
    ContentView()
}

//VStack(spacing: 0) {
//    List {
//        Section("Select Multiplication Table") {
//            Picker("Multiplication table", selection: $selectedTable) {
//                ForEach(MultiplicationTable.Tables.tableChoices, id: \.self) { tableName in
//                    Text(tableName)
//                }
//            }
//            .pickerStyle(.wheel)
//        }
//        
//        Section("Select Number of Questions") {
//            Picker("No. of Questions", selection: $questionCount) {
//                ForEach(questionCountChoices, id: \.self) { count in
//                    Text(count, format: .number)
//                }
//            }
//        }
//        .pickerStyle(.segmented)
//        
//    }
//    
//    
//    Button {
//        isQuestionsPresented = true
//    } label: {
//        Text("Confirm")
//            .frame(maxWidth: .infinity)
//            .background(.blue)
//            .foregroundStyle(.white)
//            .font(.title)
//        
//    }
//    
//}
//.navigationDestination(isPresented: $isQuestionsPresented) {
//    QuestionsView(game: .init(table: selectedTable, questionCount: questionCount))
//}
