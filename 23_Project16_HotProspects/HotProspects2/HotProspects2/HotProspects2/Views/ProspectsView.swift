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
    @State var selectedProspects = Set<Prospect>()
    
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
            List(prospects, selection: $selectedProspects, rowContent: { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }
                    if prospect.isContacted {
                        Button("Mark uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                    }
                }
                .tag(prospect)
            })
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Scan", systemImage: "qrcode.viewfinder") {
                            isShowingScanner = true
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    
                    if !selectedProspects.isEmpty {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Delete selected", role: .destructive, action: delete)
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
    
    func delete() {
        for selectedProspect in selectedProspects {
            modelContext.delete(selectedProspect)
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
