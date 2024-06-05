//
//  Moonshot.swift
//  12_Project9
//
//  Created by Dexter Ramos on 6/6/24.
//

import Foundation

enum Moonshot {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

extension DateFormatter {
    static let moonShotDateFormatter: DateFormatter = Moonshot.dateFormatter
}
