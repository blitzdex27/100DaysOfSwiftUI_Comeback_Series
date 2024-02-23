//
//  Helper.swift
//  WeSplit_retry3
//
//  Created by Dexter Ramos on 2/14/24.
//

import Foundation

enum Helper {
    static let moneyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    static let moneyFormattingStyle = FloatingPointFormatStyle<Double>.Currency(code: "PHP")
    
    static let percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.locale = .current
        return formatter
    }()
    
    static let percentFormattingStyle: FloatingPointFormatStyle<Double>.Percent = {
        let formatter = FloatingPointFormatStyle<Double>.Percent()
        return formatter
    }()
}
