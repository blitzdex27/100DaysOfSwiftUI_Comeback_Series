//
//  EditProspectView.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 1/5/25.
//

import SwiftUI

struct EditProspectView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var prospect: Prospect
    
    var body: some View {
        @Bindable var prospect = prospect
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Prospect Name", text: $prospect.name)
                }
                Section("Email address") {
                    TextField("Prospect Email Address", text: $prospect.emailAddress)
                }
            }
            .navigationTitle("Edit Prospect")
            .toolbar {
                Button("Done") {
                    do {
                        try modelContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "Test", emailAddress: "test@test.com", isContacted: false))
}
