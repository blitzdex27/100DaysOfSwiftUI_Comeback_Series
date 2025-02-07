//
//  RotatableDraggableCardView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/7/25.
//

import SwiftUI

struct RotatableDraggableCardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        CardView(card: card)
            .rotationEffect(rotationValue())
            .draggable(onX: true, onY: false, offset: $offset, shouldGoBack: true)
            .opacity(opacityValue())
            .animation(.bouncy, value: offset)
            .onChange(of: offset, {
                if abs(offset.width) > 300 {
                    removal?()
                }
            })
    }
    
    func rotationValue() -> Angle {
        let distance = 450.0
        let angle = 90.0
        
        let anglePerDistance = angle / distance
        let resultingAngle = offset.width * anglePerDistance
        
        return Angle(degrees: resultingAngle)
    }
    
    func opacityValue() -> CGFloat {
        let distance = 450.0
        let opacity = 1.0
        
        let opacityPerDistance = opacity / distance
        let resultingAngle = 1 - (abs(offset.width) * opacityPerDistance)
        
        return CGFloat(resultingAngle)
    }
}

#Preview {
    RotatableDraggableCardView(card: .example)
}
