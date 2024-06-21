//
//  ContentView.swift
//  15_Project11_Bookworm
//
//  Created by Dexter  on 6/21/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        sort: [
            SortDescriptor(
                \Book.rating,
                 order: .reverse
            ),
            SortDescriptor(\Book.title)
        ]
    ) private var books: [Book]
    
    @State private var isShowingAddBookView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Count: \(books.count)")
                List {
                    ForEach(books) { book in
                        
                        NavigationLink(value: book) {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)
                                    Text(book.author)
                                        .foregroundStyle(.secondary)
                                }
                                /// Challenge 2
                                .foregroundStyle(book.rating == 1 ? .red : .primary)
                                
                            }
                        }
                        
                    }
                    .onDelete(perform:delete)
                    
                }
            }
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
                ToolbarItem(placement: .automatic) {
                    EditButton()
                }
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
        }
    }
    
    func delete(for indexSet: IndexSet) {
        for index in indexSet {
            let book = books[index]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
