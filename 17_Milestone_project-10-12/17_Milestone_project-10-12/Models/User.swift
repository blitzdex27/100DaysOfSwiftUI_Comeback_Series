/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import SwiftData

@Model
class User : Codable {
	let id : String?
	let isActive : Bool?
	let name : String?
	let age : Int?
	let company : String?
	let email : String?
	let address : String?
	let about : String?
	let registered : Date?
	let tags : [String]?
	var friends : [Friends]?
    
    var unWrapped: UnWrapped {
        UnWrapped(user: self)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isActive = "isActive"
        case name = "name"
        case age = "age"
        case company = "company"
        case email = "email"
        case address = "address"
        case about = "about"
        case registered = "registered"
        case tags = "tags"
        case friends = "friends"
    }
    init(id: String?, isActive: Bool?, name: String?, age: Int?, company: String?, email: String?, address: String?, about: String?, registered: Date?, tags: [String]?, friends: [Friends]?) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        age = try container.decodeIfPresent(Int.self, forKey: .age)
        company = try container.decodeIfPresent(String.self, forKey: .company)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        about = try container.decodeIfPresent(String.self, forKey: .about)
        registered = try container.decodeIfPresent(Date.self, forKey: .registered)
        tags = try container.decodeIfPresent([String].self, forKey: .tags)
        friends = try container.decodeIfPresent([Friends].self, forKey: .friends)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(isActive, forKey: .isActive)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(age, forKey: .age)
        try container.encodeIfPresent(company, forKey: .company)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(about, forKey: .about)
        try container.encodeIfPresent(registered, forKey: .registered)
        try container.encodeIfPresent(tags, forKey: .tags)
        try container.encodeIfPresent(friends, forKey: .friends)
    }
}

extension User {
    struct UnWrapped {
        let id : String
        let isActive : Bool
        let name : String
        let age : Int?
        let company : String
        let email : String
        let address : String
        let about : String
        let registered : Date?
        let tags : [String]
        let friends : [Friends]
        
        var ageStr: String {
            if let age = age {
                String(age)
            } else {
                "-"
            }
        }
        
        var registeredDateStr: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "y-MM-dd"
            
            if let date = registered {
                return dateFormatter.string(from: date)
            } else {
                return "-"
            }
        }
        
        init(user: User) {
            self.id = user.id ?? "-"
            self.isActive = user.isActive ?? false
            self.name = user.name ?? "-"
            self.age = user.age
            self.company = user.company ?? "-"
            self.email = user.email ?? "-"
            self.address = user.address ?? "-"
            self.about = user.about ?? "-"
            self.registered = user.registered
            self.tags = user.tags ?? []
            self.friends = user.friends ?? []
        }
    }
}

extension String? {
    var unWrapped: String {
        self ?? "-"
    }
}

//extension User: Hashable {
//    static func == (lhs: User, rhs: User) -> Bool {
//        lhs.id == lhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    
//}
