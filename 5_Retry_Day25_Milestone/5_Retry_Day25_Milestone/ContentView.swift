//
//  ContentView.swift
//  5_Retry_Day25_Milestone
//
//  Created by Dexter Ramos on 2/24/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var game: Janken.Game
    
    @State var move = Janken.Moves.randomMoveString
    
    var moves = Janken.Moves.allStringCases
    
    @State var opponentMove = "?"
    
    @State var playerMove = "?"
    
    var resultMessage: String {
        switch game.currentRound.battleResult {
        case .draw:
            return "Draw!"
        case .win:
            return "Win!"
        case .lose:
            return "Lose!"
        default:
            return ""
        }
    }
    
    @State var isShowBattleResultAlert = false
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                ZStack {
                    LinearGradient(colors: [.blue, .red], startPoint: .top, endPoint: .bottom)
                    VStack(alignment: .center, spacing: 10) {
                        Text(opponentMove)
                        score
                        Text(game.currentRound.playerMove?.rawValue ?? playerMove)
                    }
                    .autoFill()
                }
                
                moveChoices
                Button {

                    chooseMove(playerMove)
                    if battle() != nil {
                        opponentMove = game.currentRound.enemyMove.rawValue
                        isShowBattleResultAlert = true
                    }
                    
                } label: {
                    Text("Play")
                        .autoFill()
                        .foregroundStyle(.black)
                        .frame(height: 50)
                        .background(.green)
                        
                }
            }
        }
        .alert(resultMessage, isPresented: $isShowBattleResultAlert) {
            Button {
                opponentMove = "?"
                playerMove = "?"
                try? game.proceedToNextRound()
            } label: {
                Text("OK")
            }
        }
    }
    
    var moveChoices: some View {
        HStack {
            JankenButton(binding: $playerMove, move: Janken.Moves.rock)
            JankenButton(binding: $playerMove, move: Janken.Moves.paper)
            JankenButton(binding: $playerMove, move: Janken.Moves.scissors)
        }
        .frame(height: 100)
        .background(Color.blue)
    }
    
    var score: some View {
        HStack {
            Text("Score: \(game.totalPoints)")
        }
        .font(.system(size: 20))
        .frame(width: 100, height: 50, alignment: .center)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    func chooseMove(_ move: String) {
        guard let move = Janken.Moves(rawValue: move) else {
            return
        }
        game.chooseMove(move)
    }
    func battle() -> Janken.Moves.BattleResult? {
        game.startRoundBattle()

    }
}

struct JankenButton: View {
    @Binding var binding: String
    var move: Janken.Moves
    
    var body: some View {
        Button {
            binding = move.rawValue
        } label: {
            Text(move.rawValue)
                .autoFill()
        }
    }
}

struct AutoFillModifier: ViewModifier {
    let padding: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: 500))
            .minimumScaleFactor(0.001)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .padding(5)
    }
}

extension View {
    func autoFill(_ padding: CGFloat = 5) -> some View {
        modifier(AutoFillModifier(padding: padding))
    }
}

#Preview {
    ContentView(game: Janken.Game())
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(game: Janken.Game())
//    }
//}
