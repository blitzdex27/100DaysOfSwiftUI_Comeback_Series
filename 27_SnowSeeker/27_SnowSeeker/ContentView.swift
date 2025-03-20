//
//  ContentView.swift
//  27_SnowSeeker
//
//  Created by Dexter Ramos on 3/19/25.
//

import SwiftUI


struct ContentView: View {
    
    enum SortOrder {
        case normal
        case alphabetical
        case country
    }
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortOrder: SortOrder = .normal
    
    var filteredResort: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    /// Challenge 3: For a real challenge, let the user sort the resorts in ContentView either using the default order, alphabetical order, or country order.
    var sortedResorts: [Resort] {
        switch sortOrder {
        case .normal:
            filteredResort
        case .alphabetical:
            filteredResort.sorted { r1, r2 in
                r1.name < r2.name
            }
        case .country:
            filteredResort.sorted { r1, r2 in
                r1.country < r2.country
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Button("Normal") {
                        sortOrder = .normal
                    }
                    Button("Name") {
                        sortOrder = .alphabetical
                    }
                    Button("Country") {
                        sortOrder = .country
                    }
                    
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}

