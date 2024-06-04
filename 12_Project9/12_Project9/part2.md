#  <#Title#>

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                print(path.count)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    private func save() {
        guard let codableRepresentation = path.codable else {
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(codableRepresentation)
            try data.write(to: savePath)
        } catch {
            print("path cannot be saved")
        }
        
    }
}

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 0..<1000))
            .navigationTitle("Number \(number)")
            .toolbar {
                Button("Home") {
                    path = NavigationPath()
                }
            }
    }
}


struct ContentView: View {
    
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $pathStore.path)
                }
        }
        
    }
}

#Preview {
    ContentView()
}
