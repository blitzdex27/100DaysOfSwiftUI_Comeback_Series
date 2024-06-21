//
//  ContentView.swift
//  15_Project11_Bookworm
//
//  Created by Dexter  on 6/21/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query private var books: [Book]

    @State private var isShowingAddBookView = false
    
    var body: some View {
        NavigationStack {
            Text("Count: \(books.count)")
                .navigationTitle("Bookworm")
                .sheet(isPresented: $isShowingAddBookView) {
                    AddBookView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add book", systemImage: "plus") {
                            isShowingAddBookView.toggle()
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
