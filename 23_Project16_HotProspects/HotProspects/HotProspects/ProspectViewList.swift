//
//  ProspectViewList.swift
//  HotProspects
//
//  Created by Dexter  on 7/30/24.
//

import SwiftUI
import SwiftData

struct ProspectViewList: View {
    
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    let filter: FilterType
    
    @State private var showingReminderScheduled = false
    
    init(filter: FilterType, sort: SortMethod) {
        self.filter = filter
        let showContactedOnly = filter == .contacted
        
        let sortDescriptor: SortDescriptor<Prospect>
        switch sort {
        case .name:
            sortDescriptor = SortDescriptor(\Prospect.name)
        case .date:
            sortDescriptor = SortDescriptor(\Prospect.dateCreated)
        }
        
        
        if filter != .none {
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [sortDescriptor])
        } else {
            _prospects = Query(sort: [sortDescriptor])
        }

    }
    
    var body: some View {
        List(prospects) { prospect in
            NavigationLink(destination: {
                EditProspectView(prospect: prospect) { modifiedProspect in
                    if prospect != modifiedProspect {
                        prospect.name = modifiedProspect.name
                        prospect.emailAddress = modifiedProspect.emailAddress
                    }
                }
            }, label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: prospect.isContacted ? "phone.badge.checkmark" : "iphone.gen1.slash")
                }
            })
            .swipeActions {
                Button("Remind", systemImage: "bell") {
                    addNotification(for: prospect)
                }
                .tint(.orange)
            }
        }
        
        .alert("Alert scheduled!", isPresented: $showingReminderScheduled, actions: {})
    }
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            

//            var components = Calendar.current.dateComponents([.second], from: .now)
//            components.second! += 3
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: trigger, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
            showingReminderScheduled = true
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    enum SortMethod: String, CaseIterable {
        case name = "Name"
        case date = "Date"
    }
}
//
//#Preview {
//    ProspectViewList()
//}
