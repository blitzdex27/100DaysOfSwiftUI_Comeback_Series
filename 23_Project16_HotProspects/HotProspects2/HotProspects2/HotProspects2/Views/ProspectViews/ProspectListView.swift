//
//  ProspectListView.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/5/25.
//

import SwiftUI
import SwiftData

struct ProspectListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    @Binding var selectedProspects: Set<Prospect>
    let filter: ProspectsView.FilterType
    @State var isShowingNotificationPermissionAlert = false
    @State var isShowingNotificationRequestSuccessAlert = false
    
    init(selectedProspects: Binding<Set<Prospect>>, filter: ProspectsView.FilterType, sortListEnum: SortListEnum) {
        self._selectedProspects = selectedProspects
        self.filter = filter
        
        let sort: SortDescriptor<Array<Prospect>.Element>
        
        switch sortListEnum {
        case .name:
            sort = .init(\Prospect.name)
        case .email:
            sort = .init(\Prospect.emailAddress)
        case .isContacted:
            sort = .init(\Prospect.emailAddress)
        }
        
        if filter != .none {
            let isContacted = filter == .contacted
            _prospects = Query(filter: #Predicate { prospect in
                prospect.isContacted == isContacted
            }, sort: [sort])
        } else {
            _prospects = Query(sort: [sort])
        }
        

    }
    
    var body: some View {
        List(prospects, selection: $selectedProspects, rowContent: { prospect in
            NavigationLink(destination: {
                EditProspectView(prospect: prospect)
            }, label: {
                ProspectsListCell(prospect: prospect, filter: filter)
            })
            
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
        
        .alert("Permission required", isPresented: $isShowingNotificationPermissionAlert) {
            Button("Modify settings") {
                UIApplication.shared.open(URL(string: UIApplication.openNotificationSettingsURLString)!)
            }
            Button("Cancel") { }
        }
        .alert("Notification scheduled!", isPresented: $isShowingNotificationRequestSuccessAlert) {
            
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

//#Preview {
//    ProspectListView()
//}
