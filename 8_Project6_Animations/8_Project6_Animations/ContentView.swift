//
//  ContentView.swift
//  8_Project6_Animations
//
//  Created by Dexter Ramos on 3/5/24.
//

import SwiftUI

struct CornerRotationModifier: ViewModifier {
    var amount: Double
    var anchor: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        modifier(active: CornerRotationModifier(amount: -90, anchor: .topLeading), identity: CornerRotationModifier(amount: 0, anchor: .zero))
    }
}

struct ContentView: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
                
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
            
        }
    }
}

//#Preview {
//    ContentView()
//}



//struct ContentView: View {
//    
//    @State private var animationAmount = 1.0
//    var body: some View {
//        Button("Tap Me") {
//            print("tapped")
//            animationAmount += 1
//        }
//        .padding(25)
//        .clipShape(.circle)
//        .foregroundStyle(.red)
//        .overlay {
//            Circle()
//                .stroke(.red, style: .init(lineWidth: 2))
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
//        }
//        .onAppear(perform: {
//            animationAmount += 1
//        })
//        
//        
//        
//    }
//}


//animation binding

//struct ContentView: View {
//    
//    @State private var animationAmount = 1.0
//    var body: some View {
//        VStack {
//            Stepper("animation amount: \(animationAmount.formatted())", value: $animationAmount.animation(.spring(duration: 1, bounce: 0.95)))
//            Spacer()
//            
//            Button("Tap Me") {
//                print("tapped")
//            }
//            .padding(50)
//            .background(.red)
//            .clipShape(.circle)
//            .foregroundStyle(.white)
//            .font(.title)
//            .scaleEffect(animationAmount)
//        }
//    }
//}
