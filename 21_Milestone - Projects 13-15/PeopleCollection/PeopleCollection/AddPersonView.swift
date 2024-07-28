//
//  AddPersonView.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/27/24.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {
    @Environment(\.dismiss) private var dismiss
    let imageData: Data
    let onAdd: (_ imagedata: Data, _ name: String) -> Void
    
    @State var name = ""
    var body: some View {
        NavigationStack {
            VStack {
                Image(data: imageData)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                TextField("Input name", text: $name)
                Spacer()
            }
            .navigationTitle("Add Person")
            .toolbar(content: {
                ToolbarItem {
                    Button("Save", systemImage: "checkmark") {
                        onAdd(imageData, name)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            })
        }
        
    }
}

#Preview {
    AddPersonView(imageData: Data()) { imagedata, name in
        
    }
}
