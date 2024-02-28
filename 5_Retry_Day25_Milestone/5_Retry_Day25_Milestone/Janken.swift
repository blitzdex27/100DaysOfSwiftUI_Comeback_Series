//
//  Janken.swift
//  5_Retry_Day25_Milestone
//
//  Created by Dexter Ramos on 2/24/24.
//

import Foundation

enum Janken {
    struct Game {
        var currentRound: Round
        
        var rounds: [Round]
        
        var totalPoints: Int {
            rounds.reduce(0, { $0 + $1.points} )
        }
        
        init(currentRound: Round = .init(number: 1, enemyMove: .randomMove), rounds:[Round] = []) {
            self.currentRound = currentRound
            self.rounds = rounds
        }
        
        mutating func startRoundBattle() -> Moves.BattleResult? {
            currentRound.battle()
        }
        
        mutating func proceedToNextRound() throws {
            guard currentRound.canProceedToNextRound else {
                throw Error.roundNotConcluded
            }
            
            rounds.append(currentRound)
            let nextRound = Round(points: 0, number: currentRound.number + 1, enemyMove: .randomMove, playerMove: nil, battleResult: nil)
            currentRound = nextRound
        }
        
        mutating func chooseMove(_ move: Janken.Moves) {
            currentRound.chooseMove(move)
        }
        
        struct Round {
            var points: Int = 0
            var number: Int
            var enemyMove: Moves
            var playerMove: Moves?
            var battleResult: Moves.BattleResult?
            
            var canProceedToNextRound: Bool {
                return battleResult != nil
            }
            
            
//            @discardableResult
            mutating func battle() -> Moves.BattleResult? {
                guard let battleResult = playerMove?.battle(with: enemyMove) else {
                    return nil
                }
                self.battleResult = battleResult
                points += battleResult.rawValue
                return battleResult
            }
            
            mutating func chooseMove(_ move: Moves) {
                playerMove = move
            }
            
            
        }
        
        enum Error: Swift.Error {
            case roundNotConcluded
        }
    }
    
    enum Moves: String, CaseIterable {
        case rock = "🪨"
        case paper = "📃"
        case scissors = "✂️"
        
        func battle(with move: Self) -> BattleResult {
            guard self != move else {
                return .draw
            }
            
            switch self {
            case .rock:
                return move == .scissors ? .win : .lose
            case .paper:
                return move == .rock ? .win : .lose
            case .scissors:
                return move == .paper ? .win : .lose
            }
        }
        
        enum BattleResult: Int {
            case lose = -1
            case draw = 0
            case win = 1
        }
        
        static var randomMoveString: Self.RawValue {
            allCases.randomElement()!.rawValue
        }
        
        static var randomMove: Self {
            allCases.randomElement()!
        }
        
        static var allStringCases: [Self.RawValue] {
            allCases.map({ $0.rawValue })
        }
    }
}
