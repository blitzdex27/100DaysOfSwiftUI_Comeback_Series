//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Dexter  on 7/30/24.
//

import SwiftUI

struct EditProspectView: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    @State var name: String = ""
    @State var email: String = ""
    
    let onSave: (Prospect) -> Void
    
    let isNew: Bool
    
    init(prospect: Prospect? = nil, onSave: @escaping (Prospect) -> Void) {
        if let prospect {
            _name = State(wrappedValue: prospect.name)
            _email = State(wrappedValue: prospect.emailAddress)
            title = "Edit Prospect"
            isNew = false
        } else {
            title = "New Prospect"
            isNew = true
        }
        self.onSave = onSave
    }
    
    var body: some View {
        if isNew {
            NavigationStack {
                list
            }
        } else {
            list
        }
    }
    
    var list: some View {
        List {
            Section("Name") {
                TextField("Name", text: $name)
            }
            Section("Email") {
                TextField("Email", text: $email)
            }
        }
        .navigationTitle(title)
        .toolbar {
            Button("Save") {
                onSave(Prospect(name: name, emailAddress: email, isContacted: false))
                dismiss()
            }
        }
    }
}

//#Preview {
//    EditProspectView()
//}
