//
//  CheckoutView.swift
//  14_Project10_CupCakeCorner
//
//  Created by Dexter Ramos on 6/20/24.
//

import SwiftUI

struct CheckoutView: View {
    private let imageUrlStr = "https://hws.dev/img/cupcakes@3x.jpg"
    var order: Order
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: imageUrlStr), scale: 3) { phase in
                    if phase.error != nil {
                        Text("No image")
                    }
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ProgressView()
                    }
                    
                    

                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "PHP"))")
                    .font(.title)
                
                Button("Place Order", action: {})
                    .padding()
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    CheckoutView(order: Order())
}
