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
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    let filter: FilterType
    @State var isShowingScanner = false
    @State var selectedProspects = Set<Prospect>()
    @State var isShowingNotificationPermissionAlert = false
    @State var isShowingNotificationRequestSuccessAlert = false
    
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
                HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    if filter == .none {
                        Spacer()
                        let name = prospect.isContacted ? "checkmark.circle" : "exclamationmark.circle"
                        Image(systemName: name)
                            .foregroundStyle(prospect.isContacted ? .green : .orange)
                    }
                    
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
                        
                        Button("Remind me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
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
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Deks\ndeks@gmail.com", completion: handleScanResult)
                }
                .alert("Permission required", isPresented: $isShowingNotificationPermissionAlert) {
                    Button("Modify settings") {
                        UIApplication.shared.open(URL(string: UIApplication.openNotificationSettingsURLString)!)
                    }
                    Button("Cancel") { }
                }
                .alert("Notification scheduled!", isPresented: $isShowingNotificationRequestSuccessAlert) {
                    
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
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = prospect.name
            content.body = prospect.emailAddress
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
            isShowingNotificationRequestSuccessAlert = true
        }
        // more code to come
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    } else {
                        isShowingNotificationPermissionAlert = true
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
