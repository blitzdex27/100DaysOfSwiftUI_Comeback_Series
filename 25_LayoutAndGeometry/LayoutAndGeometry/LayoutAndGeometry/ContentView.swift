//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Dexter Ramos on 8/29/24.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .pink, .orange]
    
    var body: some View {
        
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row: \(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color(
                                    hue: min(proxy.frame(in: .global).midY / fullView.size.height, 0.8),
                                    saturation: 0.5,
                                    brightness: 1
                                )
                            )
                            .opacity(proxy.frame(in: .global).minY / 200)
                            .scaleEffect(
                                scale(
                                    for: fullView.size.height,
                                    midY: proxy.frame(in: .global).midY
                                )
                            )
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.width / 2) / 5,
                                axis: (x: 0, y: 1, z: 0)
                            )
                            
                    }
                    .frame(height: 40)
                    
                }
            }
        }
        
     
    }
    func scale(for screenHeight: CGFloat, midY: CGFloat) -> CGFloat {
        let screenMidY = screenHeight / 2
        
        let midYOffset = midY - screenMidY
        
        let offsetPercentage = midYOffset / screenMidY
        let scale = (offsetPercentage * 0.5)
        
        let scaleFactor = 1 + min(scale, 0.5)
        
        return scaleFactor
    }
}

#Preview {
    ContentView()
}
