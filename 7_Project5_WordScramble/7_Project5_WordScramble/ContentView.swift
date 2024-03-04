//
//  ContentView.swift
//  7_Project5_WordScramble
//
//  Created by Dexter Ramos on 3/3/24.
//

import SwiftUI

struct ContentView: View {
    
    private let stringSets: [String] = {
        if let stringSetsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"),
           let stringSets = try? String(contentsOf: stringSetsUrl)
        {
            let stringSetsArray = stringSets.components(separatedBy: "\n")
            
            return stringSetsArray
            
        }
        return []
    }()
    var body: some View {
        List(stringSets, id: \.self) {
            
            Text($0)
            

        }
        
    }
}

#Preview {
    ContentView()
}
