//
//  APIService.swift
//  17_Milestone_project-10-12
//
//  Created by Dexter  on 6/24/24.
//

import Foundation

enum APIService {
    static func getUsers() async -> [User] {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
        
        do {
            let (dataUrl, _) = try await URLSession.shared.download(for: request)
            let data = try Data(contentsOf: dataUrl)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            let decoded = try jsonDecoder.decode([User].self, from: data)
            return decoded
        } catch {
            print("error: \(error)")
            return []
        }
        
    }
}
