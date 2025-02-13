//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Dexter Ramos on 2/12/25.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50, id: \.self) { index in
                    GeometryReader { proxy in
                        Text("Row \(index)")
                            .font(.title)
                            .frame(width: proxy.size.width)
                            .background(
                                /// Challenge 3: For a real challenge make the views change color as you scroll. For the best effect, you should create colors using the Color(hue:saturation:brightness:) initializer, feeding in varying values for the hue.
                                Color(
                                    hue: proxy.frame(in: .global).minY / fullView.size.height,
                                    saturation: 1.0,
                                    brightness: 1.0
                                )
                            )
                            .rotation3DEffect(
                                .degrees(
                                    (proxy.frame(in: .global).minY - fullView.size.height / 2) / 5.0
                                ),
                                axis: (x: 0, y: 1, z: 0)
                            )
                        /// Challenge 1: Make views near the top of the scroll view fade out to 0 opacity – I would suggest starting at about 200 points from the top.
                            .opacity(proxy.frame(in: .global).minY / 200)
                        /// Challenge 2: Make views adjust their scale depending on their vertical position, with views near the bottom being large and views near the top being small. I would suggest going no smaller than 50% of the regular size.
                            .scaleEffect(
                                scale(
                                    for: proxy.frame(in: .global).minY,
                                    height: fullView.size.height
                                )
                            )
                    }
                    .frame(height: 40)
                    
                }
            }
        }
        .coordinateSpace(NamedCoordinateSpace.named("ContentView"))
        
        
    }
    
    /// for position and total height, having lower limit of 0.5 and higher limit of 1.5, when position is 0 the scale is 0.5, when position reached the total height the scale is 1.5
    func scale(for position: CGFloat, height: CGFloat) -> CGFloat {
        let lowerLimit = 0.5
        let higherLimit = 1.5
        
        let positionPercentage = position / height
        return lowerLimit + (higherLimit - lowerLimit) * positionPercentage
    }
}

#Preview {
    ContentView()
}
