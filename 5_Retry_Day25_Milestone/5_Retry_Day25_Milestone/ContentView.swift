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
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                ZStack {
                    LinearGradient(colors: [.blue, .red], startPoint: .top, endPoint: .bottom)
                    VStack {
                        Text("?")
                        HStack {
                            Text("Score: \(game.totalPoints)")
                        }
                        .font(.system(size: 20))
                        .frame(width: 100, height: 50)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Text(game.currentRound.playerMove?.rawValue ?? "?")
                    }
                    .font(.system(size: 200))
                }
                
                Picker("", selection: $move) {
                    ForEach(moves, id: \.self) { move in
                        Text(move)
                    }
                }
                .pickerStyle(.segmented)
                
                
            }
        }
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(game: Janken.Game())
    }
}
