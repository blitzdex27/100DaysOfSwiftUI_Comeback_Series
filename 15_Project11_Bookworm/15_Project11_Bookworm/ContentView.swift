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
                                
                            }
                        }
                        
                    }
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
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let books: Query<Array<Book>.Element, [Book]> = [
            
        ]
        defer {
            @Environment(\.modelContext) var modelContext
            modelContext.insert(Book(title: "Monster Hunter", author: "Johnny", genre: "Fantasy", review: "Very very nice!", rating: 5))
        }
        return ContentView(_books: books)
            .modelContainer(container)
    } catch {
        
        return ContentView()
    }
}
