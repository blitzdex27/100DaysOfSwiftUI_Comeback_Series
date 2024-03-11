//
//  SelectHowManyQuestionsView.swift
//  9_Challenge3_MultiplicationTable
//
//  Created by Dexter Ramos on 3/10/24.
//

import SwiftUI

struct SelectHowManyQuestionsView: View {
    
    var choices: [Int]
    
    var didSelectAction: (Int) -> Void
    
    var body: some View {
        VStack {
            ForEach(choices, id: \.self) { choice in
                Button {
                    didSelectAction(choice)
                } label: {
                    Text("\(choice) questions")
                        .padding(40)
                        .background(.yellow)
                        .clipShape(.capsule)
                }
            }
        }
    }
}

#Preview {
    SelectHowManyQuestionsView(choices: [5, 10, 20]) { choice in
        print("selected \(choice)")
    }
}
