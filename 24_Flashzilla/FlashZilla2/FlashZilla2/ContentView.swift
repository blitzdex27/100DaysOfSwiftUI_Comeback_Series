//
//  ContentView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var cards = [Card]()
    @State var timeRemaining = 100

    @Environment(\.scenePhase) var scenePhase
    @State private var isActive: Bool = true
    
    @State private var isShowingEditScreen = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    .font(.title)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.7))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        let card = cards[index]
                        CardView(card: card, removal: {
                            withAnimation {
                                remove(at: index)
                            }
                        })
                        .stacked(at: index, total: cards.count, distance: 10)
                        .allowsHitTesting(cards.count - 1 == index)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
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
                        isShowingEditScreen = true
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
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                remove(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as incorrect")
                        
                        Spacer()
                        Button {
                            withAnimation {
                                remove(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as incorrect")
                        
                        
                    }
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                }
                .padding()
            }
        }
        .onReceive(timer) { output in
            guard isActive && !cards.isEmpty else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if !cards.isEmpty {
                isActive = scenePhase == .active
            }
        }
        .sheet(isPresented: $isShowingEditScreen, onDismiss: resetCards) {
            EditCardView()
        }
        .onAppear(perform: resetCards)
    }
    
    private func remove(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    private func resetCards() {
        loadData()
        timeRemaining = 100
        isActive = true
        
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            do {
                let decoded = try JSONDecoder().decode([Card].self, from: data)
                cards = decoded
            } catch {
                
            }
            
        }
    }
}



extension View {
    func stacked(at position: Int, total: Int, distance: CGFloat) -> some View {
        let offsetY = CGFloat(total - position) * distance
        
        return self
            .offset(x: 0, y: offsetY)
            
    }
}

#Preview {
    ContentView()
}
