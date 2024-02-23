//
//  ContentView.swift
//  Retry_Project2
//
//  Created by Dexter Ramos on 2/22/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var game: GuessTheFlag.Game = GuessTheFlag.Game()
    
    var round: GuessTheFlag.Game.Round {
        game.currentRound
    }
    
    var flagToGuess: GuessTheFlag.Flag {
        round.flagToGuess
    }
    
    var flagChoices: [GuessTheFlag.Flag] {
        round.flagChoices
    }
    
    @State var isShowAlert: Bool = false
    
    @State var alertTitle: String = "Correct"
    
    @State var points: Int = 0
    
    var body: some View {
        
        ZStack {
            backgroundView
            VStack {
                headerView
                flagButtons
                pointsView
                newGameButtonView
            }
        }
        .alert(alertTitle, isPresented: $isShowAlert, presenting: round) { round in
            Button("OK") {
                game.proceedToNextRound()
                points = game.totalPoints
            }
        } message: { round in
            HStack {
                Text("Choice: \(round.flagChosen!.rawValue)\nCorrect flag is: \(round.flagToGuess.rawValue)")
            }
        }
    }
    
    var headerView: some View {
        Group {
            Text("Round \(round.number)")
                .foregroundStyle(.secondary)
            Text("Guess The Flag!")
                .font(.title)
            Text(flagToGuess.rawValue)
                .font(.largeTitle.bold())
            
        }
    }
    var newGameButtonView: some View {
        HStack {
            Button("New Game") {
                game = .init()
                points = 0
            }
            .buttonStyle(.borderedProminent)
        }
    }
    var pointsView: some View {
        HStack {
            Text("Points:")
                .font(.title)
            Text(String(points))
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
        }
    }
    var flagButtons: some View {
        VStack {
            
            ForEach(flagChoices, id: \.self) { choice in
                Button(action: {
                    didTapFlag(of: choice)
                }, label: {
                    Image(choice.rawValue, bundle: .main)
                        .resizable()
                })
                .clipShape(.capsule)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
            }
            
        }
    }
    
    var backgroundView: some View {
        RadialGradient(gradient: Gradient(stops: [.init(color: .blue, location: 0.2), .init(color: .brown, location: 0.2)]), center: .top, startRadius: 200, endRadius: 300)
            .ignoresSafeArea()
    }
    func didTapFlag(of choice: GuessTheFlag.Flag) {
        
        if game.currentRound.guessTheFlag(with: choice) {
            alertTitle = "Correct!"
        } else {
            alertTitle = "Wrong!"
        }
        
        isShowAlert = true
    }
}

#Preview {
    ContentView()
}
