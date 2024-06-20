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
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
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
                
                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                    .padding()
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("Ok") {
                
            }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakesss")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.count)x \(Order.options[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout fialed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
