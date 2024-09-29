//
//  Persistable.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/28/24.
//

import Foundation

//protocol Persistable: Codable {
//    func save(fileName: String?) async throws -> Bool
//    static func load(fileName: String?) async throws -> Self
//}
//
//extension Persistable {
//    func save(fileName: String? = nil) async throws -> Bool {
//        let fileName = fileName ?? String(describing: type(of: self))
//        let url = URL.documentsDirectory.appendingPathExtension(fileName)
//        let encoded = try JSONEncoder().encode(self)
//        try encoded.write(to: url)
//        return true
//    }
//    
//    static func load(fileName: String? = nil) async throws -> Self {
//        let fileName = fileName ?? String(describing: Self.self)
//        let url = URL.documentsDirectory.appendingPathExtension(fileName)
//        let data = try Data(contentsOf: url)
//        let decoded = try JSONDecoder().decode(Self.self, from: data)
//        return decoded
//    }
//}
