//
//  Favorites.swift
//  27_SnowSeeker
//
//  Created by Dexter Ramos on 3/20/25.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    private static let saveUrl = URL.documentsDirectory.appending(path: "\(Favorites.self)") //Bundle.main.url(forResource: "\(Favorites.self)", withExtension: "savefile")
    
    init() {
        resorts = Self.load()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    /// Challenge 2: Fill in the loading and saving methods for Favorites.
    func save() {
        do {
            let encoded = try JSONEncoder().encode(resorts)
            try encoded.write(to: Self.saveUrl)
            
        } catch {
            print("Failed to save with error: \(error)")
        }
    }
    
    static func load() -> Set<String> {
        do {
            let data = try Data(contentsOf: saveUrl)
            let decoded = try JSONDecoder().decode(Set<String>.self, from: data)
            return decoded
        } catch {
            print("Failed to load with error: \(error)")
            return []
        }
    }
}
