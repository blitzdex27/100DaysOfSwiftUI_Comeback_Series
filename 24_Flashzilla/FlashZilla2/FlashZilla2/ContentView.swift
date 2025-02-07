//
//  ContentView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private var cards = Array(repeating: Card.example, count: 10)
    @State var timeRemaining = 100

    @Environment(\.scenePhase) var scenePhase
    @State private var isActive: Bool = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(.background)
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
            
            if differentiateWithoutColor {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                }
                .padding()
            }
        }
        .onReceive(timer) { output in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if !cards.isEmpty {
                isActive = scenePhase == .active
            }
        }
    }
    
    private func remove(at index: Int) {
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    private func resetCards() {
        cards = Array(repeating: .example, count: 10)
        timeRemaining = 100
        isActive = true
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
