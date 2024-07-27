//
//  PeopleStore.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/27/24.
//

import Foundation

class PeopleStore {
    var people: [Person] {
        didSet {
            save()
        }
    }
    
    private let saveUrl = URL.documentsDirectory.appendingPathComponent("SavePath")
    
    init() {
        do {
            let data = try Data(contentsOf: saveUrl)
            let decoded = try JSONDecoder().decode([Person].self, from: data)
            people = decoded
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(people)
            try encoded.write(to: saveUrl)
        } catch {
            print("unable to save")
        }
    }
}
