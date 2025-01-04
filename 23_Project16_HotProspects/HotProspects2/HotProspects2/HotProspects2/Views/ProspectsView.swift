//
//  ProspectsView.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/3/25.
//

import SwiftUI
import SwiftData
import CodeScanner

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    let filter: FilterType
    @State var isShowingScanner = false
    
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted"
        case .uncontacted:
            "Uncontacted"
        }
    }
    
    
    init(filter: FilterType) {
        self.filter = filter
        if filter != .none {
            let isContacted = filter == .contacted
            _prospects = Query(filter: #Predicate { prospect in
                prospect.isContacted == isContacted
            }, sort: \Prospect.name)
        }
    }
    
    var body: some View {
        NavigationStack {
            List(prospects, rowContent: { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            })
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem {
                        Button("Scan", systemImage: "qrcode.viewfinder") {
                            isShowingScanner = true
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Dexter Ramos\nblitzdex27@gmail.com", completion: handleScanResult)
                }
        }
    }
    
    func handleScanResult(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let prospect = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(prospect)
        case .failure(let failure):
            return
        }
        
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
