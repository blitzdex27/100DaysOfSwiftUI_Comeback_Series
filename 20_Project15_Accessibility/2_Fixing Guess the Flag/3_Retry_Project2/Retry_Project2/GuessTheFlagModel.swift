//
//  GuessTheFlagModel.swift
//  Retry_Project2
//
//  Created by Dexter Ramos on 2/22/24.
//

import Foundation

enum GuessTheFlag {
    enum Flag: String, CaseIterable {
        case estonia = "Estonia"
        case france = "France"
        case germany = "Germany"
        case ireland = "Ireland"
        case italy = "Italy"
        case monaco = "Monaco"
        case nigeria = "Nigeria"
        case poland = "Poland"
        case spain = "Spain"
        case uk = "UK"
        case ukrain = "Ukraine"
        case us = "US"
        
        static func getRandomFlags(count: Int) -> [Self] {
            guard count <= Flag.allCases.count else {
                fatalError("Out of bounds")
            }
            
            var flags = [Flag]()
            
            while flags.count < count {
                if let randomFlag = Flag.allCases.randomElement(),
                   !flags.contains(randomFlag)
                {
                    flags.append(randomFlag)
                }
            }
            
            return flags
        }

        var accessibilityLabel: String {
            let labels = [
                "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
                "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
                "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
                "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
                "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
                "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
                "Monaco": "Flag with two horizontal stripes. Top stripe red, bottom stripe white.",
                "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
                "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
                "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
                "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
                "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
            ]
            
            return labels[self.rawValue, default: "Invalid flag, do not choose"]
        }
    }
    
    struct Game {
        var rounds = [Round]()
        var currentRound: Round
        var totalPoints: Int {
            rounds.reduce(0) { partialResult, round in
                return partialResult + round.points
            }
        }
        
        init(rounds: [Round] = [Round](), 
             currentRound: Round = Round(number: 1, choiceCount: 3)
        ) {
            self.rounds = rounds
            self.currentRound = currentRound
        }
        
        mutating func proceedToNextRound() {
            rounds.append(currentRound)
            currentRound = currentRound.next()
        }
        
        struct Round {
            private let choiceCount: Int
            let number: Int
            let flagChoices: [Flag]
            let flagToGuess: Flag
            var flagChosen: Flag?
            
            private(set) var points: Int = 0
            
            init(number: Int, choiceCount: Int) {
                guard choiceCount > 0 else {
                    fatalError("Choices should be greater than zero")
                }
                self.number = number
                self.choiceCount = choiceCount
                flagChoices = Flag.getRandomFlags(count: choiceCount)
                flagToGuess = flagChoices.randomElement()!
            }
            
            func next() -> Round {
                return Round(number: number + 1, choiceCount: choiceCount)
            }
            
            mutating func win(with points: Int = 1) {
                self.points += points
            }
            
            mutating func lose(with points: Int = 1) {
                self.points -= points
            }
            
            mutating func guessTheFlag(with flag: Flag) -> Bool {
                flagChosen = flag
                let isWin = flag == flagToGuess
                if isWin {
                    win()
                } else {
                    lose()
                }
                return isWin
            }
            
        }
    }
    
    
    
    
}
