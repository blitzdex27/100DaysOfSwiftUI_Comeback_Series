//
//  EditLocation.swift
//  19_Project14_Maps
//
//  Created by Dexter  on 7/19/24.
//

import SwiftUI

struct EditLocation: View {
    
    @Environment(\.dismiss) private var dismiss
    let onSave: (Location) -> Void
    let onDelete: (Location) -> Void
    
    @State private var viewModel: ViewModel
    
    init(location: Location, onSave: @escaping (Location) -> Void, onDelete: @escaping (Location) -> Void) {
        self._viewModel = State(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $viewModel.name)
                }
                Section("Description") {
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Edit location")
            .toolbar(content: {
                ToolbarItem {
                    Button("Save") {
                       
                        onSave(viewModel.makeUpdatedLocationDetails())
                        dismiss()
                    }
                }
                ToolbarItem(placement: .destructiveAction) {
                    Button("Delete", systemImage: "trash") {
                        onDelete(viewModel.location)
                        dismiss()
                    }
                }
            })
            .onAppear(perform: {
                Task {
                    await fetchNearby()
                }
            })
        }
        

    }
    private func fetchNearby() async {
        /// let urlString = #"https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)|\(location.longitude)&action=query&prop=coordinates|pageimages|pageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"#
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "en.wikipedia.org"
        components.path = "/w/api.php"
        components.queryItems = [
            URLQueryItem(name: "ggscoord", value: "\(viewModel.location.latitude)|\(viewModel.location.longitude)"),
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "prop", value: "coordinates|pageimages|pageterms"),
            URLQueryItem(name: "colimit", value: "50"),
            URLQueryItem(name: "piprop", value: "thumbnail"),
            URLQueryItem(name: "pithumbsize", value: "500"),
            URLQueryItem(name: "pilimit", value: "50"),
            URLQueryItem(name: "wbptterms", value: "description"),
            URLQueryItem(name: "generator", value: "geosearch"),
            URLQueryItem(name: "ggsradius", value: "10000"),
            URLQueryItem(name: "ggslimit", value: "50"),
            URLQueryItem(name: "format", value: "json")
        ]
        
        if let url = components.url {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                print(String(data: data, encoding: .utf8)!)
                let items = try JSONDecoder().decode(Result.self, from: data)
                viewModel.pages = items.query.pages.values.sorted(by: { $0.title < $1.title })
                viewModel.loadingState = .loaded
            } catch {
                viewModel.loadingState = .failed
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditLocation(location: .example) { _ in
            
        } onDelete: { _ in
            
        }
    }
}
