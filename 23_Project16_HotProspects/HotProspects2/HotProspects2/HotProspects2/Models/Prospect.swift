//
//  Prospect.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/4/25.
//
import SwiftData

@Model
class Prospect: Identifiable {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
