//
//  CardView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    @State var isShowingAnswer: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack {
                Text("\(card.prompt)")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowingAnswer {
                    Text("\(card.answer)")
                        .font(.title)
                        .foregroundStyle(.secondary)

                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
   
        }
        .frame(width: 450, height: 250)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

#Preview {
    CardView(card: .example)
}
