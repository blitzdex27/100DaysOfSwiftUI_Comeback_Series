//
//  CardView.swift
//  Flashzilla
//
//  Created by Dexter  on 8/2/24.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) private var accessibilityDifferentiateWithoutColor
    let card: Card
    @Environment(\.accessibilityVoiceOverEnabled) private var accessibilityVoiceOverEnabled
    
    var removal: ((Bool) -> Void)? = nil
    
    
    @State private var offset: CGSize = CGSize.zero
    
    @State private var isShowingAnswer = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white.opacity(
                        1 - Double(
                            abs(
                                offset.width / 50
                            )
                        )
                    )
                )
                .background {
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                        .shadow(radius: 10)
                    
                }
                .shadow(radius: 10)
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
            
        }
        .frame(width: 450, height: 250)
        .gesture(
            TapGesture(count: 2)
                .onEnded({ _ in
                    isShowingAnswer.toggle()
                })
        )

        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 1)
//        .opacity(2 - abs(offset.width) / 50.0)
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    print(value.translation.width)
                    offset = value.translation
                })
                .onEnded({ value in
                    if offset.width > 100 {
                        removal?(true)
                    } else if offset.width < -100 {
                        removal?(false)
                    } else {
                        withAnimation {
                            offset = .zero
                        }
                    }
                    offset = .zero
                })
        )
//        .animation(.bouncy, value: offset)
    }
}

extension CGSize {
    
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        let resultingWitdh = lhs.width + rhs.width
        let resultingHeight = lhs.height + rhs.height
        return CGSize(width: resultingWitdh, height: resultingHeight)
    }
    
}

#Preview {
    CardView(card: .example)
}
