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
        VStack {
            TextField("Input name", text: $name)
            Button("Add") {
                onAdd(imageData, name)
                dismiss()
            }
        }
        
    }
}

#Preview {
    AddPersonView(imageData: Date()) { imagedata, name in
        
    }
}
