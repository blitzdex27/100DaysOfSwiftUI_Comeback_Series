//
//  QuestionsView.swift
//  9_Challenge3_MultiplicationTable
//
//  Created by Dexter Ramos on 3/10/24.
//

import SwiftUI

struct QuestionsView: View {
    
    var game: MultiplicationTable.Game
    
    var didTapGobackAction: (Int) -> Void
    
    var questions: [MultiplicationTable.Question] {
        game.questions
    }
    
    @State var questionNumber = 0
    
    var currentQuestion: MultiplicationTable.Question? {
        if questionNumber < questions.count {
            return questions[questionNumber]
        } else {
            return nil
        }
    }
    
    @State var currentAnswer: Int? = nil
    
    var body: some View {
        VStack(spacing: 50) {
            HStack {
                
                Text("Current points:")
                Text("\(game.totalPoints)")
            }
            .padding(20)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .foregroundStyle(.white)
            if let currentQuestion = currentQuestion {
                
                Text("Question: \(currentQuestion.description)")
                    .padding(20)
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                VStack {
                    Text("Answer")
                    TextField("", value: $currentAnswer, format: .number)
                        .frame(width: 200, height: 50)
                        .background(.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.center)
                        .onSubmit {
                            handleSubmit(for: currentQuestion)
                        }
                    
                }
                
                Button("Submit") {
                    handleSubmit(for: currentQuestion)
                }
                
            } else {
                Text("No more questions!")
                Button("Start Again") {
                    didTapGobackAction(game.totalPoints)
                }
            }
            
        }
    }
    
    func handleSubmit(for question: MultiplicationTable.Question) {
        if let currentAnswer = currentAnswer
        {
            if question.isCorrectAnswer(currentAnswer) {
                game.addPoint()
            }
            withAnimation {
                questionNumber += 1
            }
        }
    }
}

#Preview {
    QuestionsView(game: .init(table: "x3", questionCount: 5)) { _ in
        
    }
}
