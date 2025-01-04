//
//  ProspectsView.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/3/25.
//

import SwiftUI
import SwiftData
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    
    let filter: FilterType
    @State var sortListEnum: SortListEnum = .name
    
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

    }
    
    var body: some View {
        NavigationStack {
            ProspectListView(selectedProspects: $selectedProspects, filter: filter, sortListEnum: sortListEnum)
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
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort") {
                            Button("Name") {
                                sortListEnum = .name
                            }
                            Button("Email") {
                                sortListEnum = .email
                            }
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Deks\ndeks@gmail.com", completion: handleScanResult)
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
            
            if let prospect = selectedProspects.remove(selectedProspect) {
                modelContext.delete(prospect)
            }
        }
    }
    
    
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
