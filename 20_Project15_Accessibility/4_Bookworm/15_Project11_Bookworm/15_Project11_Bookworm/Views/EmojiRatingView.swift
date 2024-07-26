//
//  EmojiRatingView.swift
//  15_Project11_Bookworm
//
//  Created by Dexter  on 6/21/24.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int
    
    var body: some View {
        switch rating {
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        default:
            Text("5")
        }
    }
}

#Preview {
    EmojiRatingView(rating: 3)
}
