//
//  ContentView.swift
//  Flashzilla
//
//  Created by Dexter  on 7/30/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.accessibilityEnabled) private var accessibilityEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) private var accessibilityDifferentiateWithoutColor
    
    @Query private var cards: [Card]//Array(repeating: Card.example, count: 10)
    @State private var gameCards = [Card]()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                ZStack {
                    ForEach(gameCards) { card in
                        let index = gameCards.firstIndex(where: { $0 == card})!
                        CardView(card: card){ isCorrect in
                            withAnimation {
                                removeCard(at: index, isCorrect: isCorrect)
                            }
                        }
                        .stacked(at: index, in: gameCards.count)
                        .allowsHitTesting(index == gameCards.count - 1)
                        .accessibilityHidden(index < gameCards.count - 1)
                    }
//                    ForEach(cards) { card in
//                        let index = cards.firstIndex(where: { $0 == card})
//                        CardView(card: cards[index]){ isCorrect in
//                            withAnimation {
//                                removeCard(at: index, isCorrect: isCorrect)
//                            }
//                        }
//                        .stacked(at: index, in: cards.count)
//                        .allowsHitTesting(index == cards.count - 1)
//                        .accessibilityHidden(index < cards.count - 1)
//                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if gameCards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            if accessibilityDifferentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { output in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if gameCards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int, isCorrect: Bool) {
        guard index >= 0 else { return }
        
        var cardToTryAgain: Card?
        
        if !isCorrect {
            cardToTryAgain = gameCards[index]
            cardToTryAgain?.id = UUID()

        }
//        
        gameCards.remove(at: index)
        
        if let cardToTryAgain {
            gameCards.insert(cardToTryAgain, at: 0)
            gameCards.forEach({ print($0.prompt)})
        }

        if gameCards.isEmpty {
            isActive = false
        }
    }
    func resetCards() {
        timeRemaining = 100
        isActive = true
        gameCards = cards
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}



#Preview {
    ContentView()
}
