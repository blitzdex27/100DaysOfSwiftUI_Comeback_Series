//
//  DraggableCardView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//

import SwiftUI


struct DraggableCardView: View {
    let card: Card
    var shouldTranslateX: Bool = true
    var shouldTranslateY: Bool = false
    
    @State var offset: CGSize = .zero
    @State var offsetFinal: CGSize = .zero
    
    var body: some View {
        CardView(card: card)
            .offset(offset)
            
    }
}

#Preview {
    DraggableCardView(card: .example)
}
