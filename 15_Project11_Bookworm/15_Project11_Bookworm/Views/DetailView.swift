//
//  DetailView.swift
//  15_Project11_Bookworm
//
//  Created by Dexter  on 6/21/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let book: Book
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteAlert = false
    
    /// Challenge 3
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    var body: some View {
        /// Challenge 3
        ScrollView {
            ZStack(alignment: .topLeading) {
                
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    Text(book.genre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x: -5, y: -5)
                }
                Text(book.date, formatter: dateFormatter)
                    .font(.caption)
                    .italic()
                    .padding(7)
                    .background(.black.opacity(0.4))
                    .clipShape(.capsule)
                    .foregroundStyle(.white.opacity(0.7))
                    .offset(x: 5, y: 5)
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Are you sure you want to delete the book:\n\(book.title) written by \(book.author)", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                modelContext.delete(book)
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        }
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Delete", systemImage: "trash") {
                    showingDeleteAlert.toggle()
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let exampleBook = Book(title: "Example book", author: "Example auther", genre: "Fantasy", review: "Example review", rating: 2)
        return NavigationStack {
            DetailView(book: exampleBook)
                .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    
}
