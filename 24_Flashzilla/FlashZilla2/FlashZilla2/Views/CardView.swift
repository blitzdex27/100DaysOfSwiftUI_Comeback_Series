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
    var removal: ((Bool) -> Void)? = nil
    
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
                .signedFilledBackground(offset.width, shape: {
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                })
                .shadow(radius: 10)
            ZStack {
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
       
            }
            .padding(20)
            .multilineTextAlignment(.center)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Correct stat: \(card.correctCount)")
                        .padding()
                }
            }
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
                let offsetWidth = offset.width
                
                if abs(offsetWidth) > 300 {
                    removal?(offsetWidth > 0)
                }
                
                offset = .zero
                
            }
        )
        
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

/// Challenge: If you drag a card to the right but not far enough to remove it, then release, you see it turn red as it slides back to the center. Why does this happen and how can you fix it? (Tip: think about the way we set offset back to 0 immediately, even though the card hasn’t animated yet. You might solve this with a ternary within a ternary, but a custom modifier will be cleaner.)
struct SignedFilledBackgroundModifier<S: Shape>: ViewModifier {
    
    var value: CGFloat
    @ViewBuilder var shape: () -> S?
    var positiveColor: Color = .green
    var negativeColor: Color = .red
    var neutralColor: Color = .clear
    
    func body(content: Content) -> some View {
        content
            .background {
                if let s = shape() {
                    s.fill(backgroundFill)
                } else {
                    EmptyView()
                }
            }
    }
    
    var backgroundFill: Color {
        if value > 0 {
            return positiveColor
        } else if value < 0 {
            return negativeColor
        } else {
            return neutralColor
        }
    }
}

extension View {
    func signedFilledBackground<S: Shape>(_ value: Double, @ViewBuilder shape: @escaping () -> S?) -> some View {
        modifier(SignedFilledBackgroundModifier(value: value, shape: shape))
    }
}
#Preview {
    CardView(card: .example)
}
