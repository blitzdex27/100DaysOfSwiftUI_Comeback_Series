//
//  AppModel.swift
//  10_Project7
//
//  Created by Dexter Ramos on 6/23/24.
//

import Foundation
import SwiftUI

@Observable
class AppModel {
    let expenseTypes: [String]
    let currencyCodes: [String]
    var selectedCurrency: String
    
    init(expenseTypes: [String], currencyCodes: [String], selectedCurrency: String) {
        self.expenseTypes = expenseTypes
        self.currencyCodes = currencyCodes
        self.selectedCurrency = selectedCurrency
    }
}

extension AppModel {
    var filters: [String] {
        var filters = [String]()
        filters.append("All")
        filters.append(contentsOf: expenseTypes)
        return filters
    }
}

extension AppModel {
    static let dummyExpenseTypes = ["Personal", "Business"]
    static let dummyCurrencyCodes = ["PHP", "USD"]
    static let dummySelectedCurrency = "PHP"
    
    static func makeDummy() -> AppModel {
        AppModel(
            expenseTypes: dummyExpenseTypes,
            currencyCodes: dummyCurrencyCodes,
            selectedCurrency: dummySelectedCurrency
        )
    }
}

extension EnvironmentValues {
    var appModel: AppModel {
        get { self[AppModel.self] }
        set { self[AppModel.self] = newValue}
    }
}

extension AppModel: EnvironmentKey {
    static let defaultValue = AppModel.makeDummy()
}
