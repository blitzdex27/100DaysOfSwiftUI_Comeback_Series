//
//  MultiplicationTable.swift
//  9_Challenge3_MultiplicationTable
//
//  Created by Dexter Ramos on 3/10/24.
//

import Foundation


enum MultiplicationTable {
    
    class Game {
        private(set) var questions: [Question]
        private(set) var totalPoints = 0
        
        init(table: String, questionCount: Int) {
            let table = MultiplicationTable.Tables(tableName: table) ?? .x2
            self.questions = table.generateQuestions(with: questionCount)
        }
        
        func addPoint(_ point: Int = 1) {
            totalPoints += point
        }
        
        
    }
    
    struct Question: Hashable {
        var id = UUID().uuidString
        var description: String
        var answer: Int
        
        func isCorrectAnswer(_ answer: Int) -> Bool {
            self.answer == answer
        }
        
        init(num1: Int, num2: Int) {
            description = "\(num1) x \(num2)"
            answer = num1 * num2
        }
    }
    
    enum Tables: Int, CaseIterable {
        case x1 = 1
        case x2
        case x3
        case x4
        case x5
        case x6
        case x7
        case x8
        case x9
        case x10
        case x11
        case x12
        
        init?(tableName: String) {
            let tableName = tableName.replacing(/$x/, with: "")
            guard let rawValue = Int(tableName) else {
                return nil
            }
            self.init(rawValue: rawValue)
        }
        
        static let tableNames: [String] = { Self.allCases.map({ "x\($0.rawValue)" }) }()
        
        static let tableChoices: [String] = { Array(tableNames[1..<Self.allCases.count]) }()
        
        func generateQuestions(with count: Int) -> [Question] {
            var baseQuestions = [Question]()
            for i in 1...12 {
                let question = Question(num1: i, num2: self.rawValue)
                baseQuestions.append(question)
            }
            
            var questions = [Question]()
            if count >= 10 {
                questions.append(contentsOf: baseQuestions)
            }
            while questions.count != count {
                questions.append(baseQuestions.randomElement()!)
            }
            
            return questions.shuffled()
        }
    }
    
}
