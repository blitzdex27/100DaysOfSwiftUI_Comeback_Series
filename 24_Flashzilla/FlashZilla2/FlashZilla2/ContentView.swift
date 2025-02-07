//
//  ContentView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = Array(repeating: Card.example, count: 10)
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        let card = cards[index]
                        RotatableDraggableCardView(card: card, removal: {
                            withAnimation {
                                remove(at: index)
                            }
                        })
                        .stacked(at: index, total: cards.count, distance: 10)
                        
                    }
                    
                
                }
                
            }
        }
    }
    
    private func remove(at index: Int) {
        cards.remove(at: index)
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
