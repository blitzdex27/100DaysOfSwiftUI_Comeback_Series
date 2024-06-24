/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation


struct User : Codable, Identifiable {
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
	let friends : [Friends]?
    
    var unWrapped: UnWrapped {
        UnWrapped(user: self)
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
        let friends : [Friends]?
        
        var ageStr: String {
            if let age = age {
                String(age)
            } else {
                "-"
            }
        }
        
        var registeredDateStr: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-y"
            
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

extension User: Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}