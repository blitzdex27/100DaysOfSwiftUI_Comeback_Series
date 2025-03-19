## Navigation split view

```swift
struct ContentView: View {
    var body: some View {
        NavigationSplitView(preferredCompactColumn: .constant(.sidebar)) {
            NavigationLink("Primary") {
                Text("Primary content")
            }
        } detail: {
            Text("Content")
                .toolbarVisibility(.hidden, for: .navigationBar)
        }
        .navigationSplitViewStyle(.prominentDetail)


    }
}


```

## alert and sheet optional

```swift
struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Button("Tap me") {
            selectedUser = User()
            isShowingUser = true
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
                .presentationDetents([.large, .medium])
        }
//        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//            Button("Ok") {
//                print("OK")
//            }
//        } message: { user in
//            Text(user.id)
//        }
    }
}

```

## Group as transparent container

```swift
struct UserView: View {
    var body: some View {
        Group {
            Text("One")
            Text("Two")
            Text("Three")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
//    @State private var isLayoutVertically = false
    
    var body: some View {
        VStack {
            if horizontalSizeClass == .compact {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
            Button("Toggle layour") {
//                horizontalSizeClass = .regular
            }
        }
    }
}

```

## Size that fits

```
struct ContentView: View {
    var body: some View {
        ZStack {
            ViewThatFits {
                Rectangle()
                    .frame(width: 500, height: 200)
                Circle()
                    .frame(width: 200, height: 500)
            }
        }
        .frame(width: 200, height: 200)
    }
}
```

## Searchable

```
struct ContentView: View {
    @State private var searchText = ""
    
    let names = ["Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie", "Chelsea", "Dexter", "Mama", "Lorie"]
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { name in
                name.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: Text("Start searching..."))
                .navigationTitle("Searching")
        }
    }
}
```

## Environment

```
@Observable
class Player {
    var name = "Anonymouse"
    var highScore = 0
}

extension Player: EnvironmentKey {
    static var defaultValue: Player = Player()
}

extension EnvironmentValues {
    var player: Player {
        get { self[Player.self] }
        set {
            self[Player.self] = newValue
        }
    }
}

struct HighScoreView: View {
    @Environment(\.player) private var player
    
    var body: some View {
        @Bindable var player = player
        
        Text("HighScore: \(player.highScore)")
        Stepper("Score", value: $player.highScore)
    }
}

struct ContentView: View {
    
    @State private var player = Player()
    
    var body: some View {
        VStack {
            Text("Welcome!")
            HighScoreView()
        }
        .environment(player)
    }
}
```
