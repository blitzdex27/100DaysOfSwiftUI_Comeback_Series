//
//  ContentView.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/27/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    private let 
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var extractedImage: ExtractedImage?
    var body: some View {
        NavigationStack {
  
            VStack {
                
            }
            .navigationTitle("People Collection")
            .toolbar(content: {
                ToolbarItem {
                    PhotosPicker("Add person", selection: $selectedPhoto, matching: .images)
                    
                }
            })
            .sheet(item: $extractedImage) { extractedImage in
                
                AddPersonView(imageData: extractedImage.data) { imageData, name in
                    
                }
            }
            .onChange(of: selectedPhoto) { oldValue, newValue in
                Task {
                    await handleSelected(item: newValue)
                }
            }
        }
    }
    
    func handleSelected(item: PhotosPickerItem?) async {
        guard let item else {
            return
        }
        
        do {
            
            let data = try await item.loadTransferable(type: Data.self)
            
            
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
