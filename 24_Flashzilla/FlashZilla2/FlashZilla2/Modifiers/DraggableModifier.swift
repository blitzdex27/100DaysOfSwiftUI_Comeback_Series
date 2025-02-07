//
//  DraggableModifier.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//
import SwiftUI

extension View {
    func draggable(onX: Bool, onY: Bool, offset: Binding<CGSize>, shouldGoBack: Bool) -> some View {
        modifier(DraggableModifier(onX: onX, onY: onY, offset: offset, shouldGoBackToOriginalPosition: shouldGoBack))
    }
}

struct DraggableModifier: ViewModifier {
    let onX: Bool
    let onY: Bool
    let shouldGoBackToOriginalPosition: Bool
    
    @Binding var offset: CGSize
    @State var offsetFinal: CGSize = .zero
    
    init(onX: Bool, onY: Bool, offset: Binding<CGSize>, shouldGoBackToOriginalPosition: Bool) {
        self.onX = onX
        self.onY = onY
        self._offset = offset
        self._offsetFinal = State(initialValue: offset.wrappedValue)
        self.shouldGoBackToOriginalPosition = shouldGoBackToOriginalPosition
    }
    
    func body(content: Content) -> some View {
        return content
            .offset(offset)
            .gesture(DragGesture()
                .onChanged { value in
                    offset = calculateOffset(value.translation)
                }
                .onEnded { value in
                    if shouldGoBackToOriginalPosition {
                        offset = .zero
                    } else {
                        offsetFinal = offset
                    }
                }
            )
        
    }
    
    private func calculateOffset(_ translation: CGSize) -> CGSize {
        let base = offsetFinal
        let baseX = base.width
        let baseY = base.height
        let combinedX = baseX + translation.width
        let combinedY = baseY + translation.height
        let resultingOffsetX = onX ? combinedX : 0
        let resultingOffsetY = onY ? combinedY : 0
        return CGSize(width: resultingOffsetX, height: resultingOffsetY)
    }
}
