//
//  Bundle+Decodable.swift
//  11_Project8
//
//  Created by Dexter Ramos on 3/19/24.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [String: Astronaut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError()
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        
        guard let astronauts = try? JSONDecoder().decode([String: Astronaut].self, from: data) else {
            fatalError()
        }
        
        return astronauts
    }
}
