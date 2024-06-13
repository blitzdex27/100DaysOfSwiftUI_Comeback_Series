//
//  Habit.swift
//  13_Milestone_projects-7-8-9
//
//  Created by Dexter  on 6/13/24.
//

import Foundation

@Observable class Habit: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    var completionCount: Int
    
    init(id: String = UUID().uuidString, name: String, description: String, completionCount: Int = 0) {
        self.id = id
        self.name = name
        self.description = description
        self.completionCount = completionCount
    }
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(description, forKey: .description)
//        try container.encode(status.rawValue, forKey: .status)
//        
//    }
//    
//    required init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        description = try container.decode(String.self, forKey: .description)
//        
//        let statusRawValue = try container.decode(String.self, forKey: .status)
//        if let status = Status(rawValue: statusRawValue) {
//            self.status = status
//        } else {
//            self.status = .notStarted
//        }
//        
//        
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case description
//        case status
//    }
//    
//    enum Status: String, CaseIterable {
//        case notStarted = "Not Started"
//        case inProgress = "In Progress"
//        case completed = "Completed"
//    }
//    
//    init(id: String = UUID().uuidString, name: String, description: String, status: Status) {
//        self.id = id
//        self.name = name
//        self.description = description
//        self.status = status
//    }
}

extension Habit: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        lhs.id == rhs.id
    }
    
}
