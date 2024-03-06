//
//  ContentView.swift
//  8_Project6_Animations
//
//  Created by Dexter Ramos on 3/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var rotation = 0.0
    
    var body: some View {
        Button("Tap me") {
            withAnimation(.spring(duration: 1, bounce: 0.8)) {
                
                rotation += 180
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .font(.title)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}

#Preview {
    ContentView()
}



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
