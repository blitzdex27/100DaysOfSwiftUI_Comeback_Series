//
//  DiceView.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//

import SwiftUI

struct DieView: View {
    
    @State var viewModel: ViewModel
    
    @Binding var isRolling: Bool
    
    let didFinishRoll: (Int) -> Void
    
    var showControl: Bool
    
    @State var rotationAngle: Double = 0
    
    @State private var preferredSideLength: Double = 1000
    
    init(isRolling: Binding<Bool>, sides: Int = 6, showControl: Bool = true, didFinishRoll: @escaping (Int) -> Void) {
        self._isRolling = isRolling
        self.didFinishRoll = didFinishRoll
        self.viewModel = ViewModel(sides: sides)
        self.showControl = showControl
    }
    
    init(isRolling: Binding<Bool>, die: Die, showControl: Bool = true, didFinishRoll: @escaping (Int) -> Void) {
        self._isRolling = isRolling
        self.didFinishRoll = didFinishRoll
        self._viewModel = State(wrappedValue: ViewModel(die: die))
        self.showControl = showControl
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
//                .contentTransition(.numericText())
                .font(.system(size: fullView.size.width * 0.8))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .background(.black)
                .frame(width: preferredSideLength(size: fullView.size), height: preferredSideLength(size: fullView.size))
            }
            .animation(.bouncy, value: viewModel.result)
            
            .frame(idealWidth: preferredSideLength, idealHeight: preferredSideLength)
            
            if showControl {
                if  viewModel.result == nil {
                    Button("Roll", action: startRoll)
                } else {
                    Button("Reset", action: reset)
                }
            }
        }
        .contentTransition(.numericText())
        .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 1, y: 0, z: 0))
        
        .onChange(of: viewModel.result, {
            print("viewModel.result  \(viewModel.result)")

            withAnimation(.linear) {
                rotationAngle += 360
            } completion: {
                
            }

        })
        .onChange(of: isRolling) {
            if isRolling {
                rollDice()
            } else {
                
            }
        }
    }
    
    func rollDice() {
        let result = viewModel.roll()
        didFinishRoll(result)
        isRolling = false
    }
    
    func startRoll() {
        isRolling = true
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
    @Previewable @State var isRolling = false
    DieView(isRolling: $isRolling, sides: 9) { result in
        print(result)
    }
    .frame(width: 200)
}

#Preview {
    @Previewable @State var isRolling = false
    DieView(isRolling: $isRolling, sides: 9, showControl: false) { result in
        print(result)
    }
}
