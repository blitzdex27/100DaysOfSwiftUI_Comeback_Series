//
//  TableSelectionView.swift
//  9_Challenge3_MultiplicationTable
//
//  Created by Dexter Ramos on 3/10/24.
//

import SwiftUI

struct TableSelectionView: View {
    
    private var tableOptionNames: [String]
    
    private var didSelectAction: (MultiplicationTable.Tables) -> Void
    
    init(tableOptionNames: [String] = MultiplicationTable.Tables.tableChoices, didSelectAction: @escaping (MultiplicationTable.Tables) -> Void) {
        self.tableOptionNames = tableOptionNames
        self.didSelectAction = didSelectAction
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()], content: {
            ForEach(0..<tableOptionNames.count, id: \.self) { i in
                Button {
                    if let selectedTable = MultiplicationTable.Tables(rawValue: i + 1) {
                        didSelectAction(selectedTable)
                    }
                } label: {
                    Text(tableOptionNames[i])
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color(
                            red: value(i: Double(i)),
                            green: 0.6,
                            blue: value(i: Double(tableOptionNames.count - i + 1))))
                }

            }
        })
        .padding()
    }
    
    private func value(i: Double) -> Double {
        let result = Double(i + 1) / Double(tableOptionNames.count)
        print(result)
        return result
    }
}

//#Preview {
//    TableSelectionView()
//}
