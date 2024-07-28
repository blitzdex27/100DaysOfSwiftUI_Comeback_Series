//
//  ContentView.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/27/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    private let peopleStore = PeopleStore()
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var extractedImage: ExtractedImage?
    var body: some View {
        NavigationStack {
  
            VStack {
                List {
                    ForEach(peopleStore.people.sorted()) { person in
                        NavigationLink {
                            Text(person.name)
                        } label: {
                            HStack {
                                Image(data: person.imageData)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                Text(person.name)
                            }
                        }

                    }
                }
            }
            .navigationTitle("People Collection")
            .toolbar(content: {
                ToolbarItem {
                    PhotosPicker("Add person", selection: $selectedPhoto, matching: .images)
                    
                }
            })
            .sheet(item: $extractedImage) { extractedImage in
                
                AddPersonView(imageData: extractedImage.data) { imageData, name in
                    peopleStore.people.append(Person(imageData: imageData, name: name))
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
            
            if let data = try await item.loadTransferable(type: Data.self) {
                let extractedImage = ExtractedImage(data: data)
                self.extractedImage = extractedImage
            }
            
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}

extension Image {
    init(data: Data) {
        if let uiiMage = UIImage(data: data) {
            self.init(uiImage: uiiMage)
        } else {
            self.init(systemName: "photo")
        }
    }
}
