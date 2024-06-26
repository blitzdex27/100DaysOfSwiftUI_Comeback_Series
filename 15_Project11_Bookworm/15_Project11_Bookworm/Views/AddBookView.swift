//
//  AddBookView.swift
//  15_Project11_Bookworm
//
//  Created by Dexter  on 6/21/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating: Int = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    /// Challenge 1
    @State private var isTitleValid = true
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .border(isTitleValid ? .clear : .red)
                        .onChange(of: title) { oldValue, newValue in
                            isTitleValid = true
                        }
                        
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(Book.genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        // add the book
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        if newBook.isValidBookEntry {
                            modelContext.insert(newBook)
                            dismiss()
                        } else {
                            /// Challenge 1
                            isTitleValid = false
                        }
                    }
                }
            }
            .navigationTitle("Add book")
        }
    }
}

#Preview {
    AddBookView()
}
