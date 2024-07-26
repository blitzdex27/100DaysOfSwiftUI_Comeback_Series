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
    
    /// Challenge: 2. If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
    @State private var showingError = false
    @State private var errorMessage = ""
    
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
                            .accessibilityHidden(true)
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
            Button("Ok") { }
        } message: {
            Text(confirmationMessage)
        }
        /// Challenge: 2. If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
        .alert("Error", isPresented: $showingError) {
            Button("Ok") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakesss")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /// Challenge: 2. If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.count)x \(Order.options[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            /// Challenge: 2. If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
            errorMessage = error.localizedDescription
            showingError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
