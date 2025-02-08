//
//  CardView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State var offset: CGSize = .zero
    @State var isShowingAnswer: Bool = false
    
    let card: Card
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(
                            1 - (Double(abs(offset.width)) / 50.0)
                        )
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fill(backgroundFill)
                )
                .shadow(radius: 10)
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                } else {
                    Text("\(card.prompt)")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text("\(card.answer)")
                            .font(.title)
                            .foregroundStyle(.secondary)
                        
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
   
        }
        .frame(width: 450, height: 250)
        .rotationEffect(rotationValue())
//        .draggable(onX: true, onY: false, offset: $offset, shouldGoBack: true)
        .offset(offset)
        .opacity(opacityValue())
        .animation(.bouncy, value: offset)
        .accessibilityAddTraits(.isButton)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .gesture(DragGesture()
            .onChanged { value in
                offset = CGSize(width: value.translation.width * 5, height: 0)
            }
            .onEnded { value in
                offset = .zero
            }
        )
 
        .onChange(of: offset, {
            if abs(offset.width) > 300 {
                removal?()
            }
        })
    }
    
    var backgroundFill: Color {
        if offset.width > 0 {
            return .green
        } else if offset.width < 0 {
            return .red
        } else {
            return .clear
        }
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
    CardView(card: .example)
}
