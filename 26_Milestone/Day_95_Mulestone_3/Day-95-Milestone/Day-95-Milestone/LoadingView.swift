//
//  LoadingView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/21/25.
//

import SwiftUI

struct LoadingView: View {
    
    @State var timer = Timer.publish(every: 1, tolerance: 0.5, on: .current, in: .common).autoconnect()
    
    let startTime = Date()
    
    @State var elapsedTime: Double = 0
    
    
    var body: some View {
        Text("Loading... \(elapsedTime)")
            .onReceive(timer) { output in
                elapsedTime = output.timeIntervalSince(startTime)
            }
    }
    

}

#Preview {
    LoadingView()
}
