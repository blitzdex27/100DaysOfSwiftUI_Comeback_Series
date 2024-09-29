//
//  DiceView.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//

import SwiftUI

struct DieView: View {
    
    @State var viewModel: ViewModel
    
    let didFinishRoll: (Die) -> Void
    
    @State var rotationAngle: Double = 0
    
    @State private var preferredSideLength: Double = 1000
    
    init(die: Die, didFinishRoll: @escaping (Die) -> Void) {
        self.didFinishRoll = didFinishRoll
        self._viewModel = State(wrappedValue: ViewModel(die: die))
    }
    
    var body: some View {
        
        VStack {
            GeometryReader { fullView in
                Group {
                    if let result = viewModel.result {
                        Text("\(result)")
                    } else {
                        Text("??")
                    }
                }
                .minimumScaleFactor(0.5)
                .contentTransition(.numericText())
                .font(.system(size: fullView.size.width * 0.8))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .background(.black)
                .frame(width: preferredSideLength(size: fullView.size), height: preferredSideLength(size: fullView.size))
            }
            .animation(.bouncy, value: viewModel.result)
            .frame(idealWidth: preferredSideLength, idealHeight: preferredSideLength)
        }
        .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 1, y: 0, z: 0))
        
        .onChange(of: viewModel.result, {

            withAnimation(.linear) {
                rotationAngle += 360
            } completion: {
                
            }

        })
    }
    
    func rollDice() {
        let result = viewModel.roll()
        didFinishRoll(viewModel.die)
    }
    
    func rollDiceDynamically() {
        viewModel.dynamicRoll { result in
            didFinishRoll(viewModel.die)
        }
    }
    
    func reset() {
        viewModel.reset()
    }
    
    private func preferredSideLength(size: CGSize) -> Double {
        let leastSideLen = min(size.width, size.height)
        if preferredSideLength != leastSideLen {
            print("\(leastSideLen)")
            DispatchQueue.main.async {
                preferredSideLength = leastSideLen
            }
            
        }
        
        return leastSideLen
    }
}

#Preview {
    @Previewable @State var die = Die(sideCount: 6)
    DieView(die: die) { result in
        print(result)
    }
    .frame(width: 200)
}

#Preview {
    @Previewable @State var die = Die(sideCount: 6)
    DieView(die: die) { result in
        print(result)
    }
}
