//
//  TabSelectionEnv.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/3/25.
//

import SwiftUI

//extension TabEnum: EnvironmentKey {
//    static var defaultValue = TabEnum.everyone
//}
////
////extension EnvironmentValues {
////    @Entry var tabSelection: TabEnum = .everyone
////}
//
//extension EnvironmentValues {
//    var tabSelection2: TabEnum {
//        get {
//            self[TabEnum.self]
//        }
//        set {
//            self[TabEnum.self] = newValue
//        }
//    }
//}

//extension EnvironmentValues {
//    @Entry var tabConfig: TabConfig = .init()
//}



@Observable
class TabConfig {
    var selectedTab: TabEnum = .everyone
}

extension TabConfig: EnvironmentKey {
    static var defaultValue: TabConfig = .init()
}

extension EnvironmentValues {
    var tabConfig: TabConfig {
        get {
            self[TabConfig.self]
        }
        set {
            self[TabConfig.self] = newValue
        }
    }
}

