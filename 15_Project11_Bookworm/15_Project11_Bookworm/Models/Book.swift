//
//  Book.swift
//  15_Project11_Bookworm
//
//  Created by Dexter  on 6/21/24.
//

import Foundation
import SwiftData

@Model
class Book {
    
    static let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
//    var id = UUID()
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date = Date() /// Challenge 3
    
    /// Challenge 1
    var isValidBookEntry: Bool {
        isValidTitle
    }
    /// Challenge 1
    var isValidTitle: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    
    init(title: String, author: String = "Anonymous", genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}
