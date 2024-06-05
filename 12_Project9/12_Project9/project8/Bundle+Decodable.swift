//
//  Bundle+Decodable.swift
//  11_Project8
//
//  Created by Dexter Ramos on 3/19/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String, type: T.Type, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError()
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError()
        }
        
        return decoded
    }
}
