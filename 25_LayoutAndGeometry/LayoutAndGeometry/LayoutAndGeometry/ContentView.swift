//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Dexter Ramos on 8/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<100) { index in
                        Text("Number \(index)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .frame(width: 200, height: 200)
                            .visualEffect { content, proxy in
                                content
                                    .rotation3DEffect(
                                        .degrees(-proxy.frame(in: .global).minX / 8),
                                        axis: (0, 1, 0)
                                    )
                            }
                    
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    ContentView()
}
