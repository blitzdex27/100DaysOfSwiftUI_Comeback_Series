#  <#Title#>

```
struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    
    @State private var selection = Set<String>()

    var body: some View {
        NavigationStack {
            VStack {
                List(users, id: \.self, selection: $selection) { user in
                    Text(user)
                }
                Text("You selected \(selection.formatted())")
            }
            .toolbar(content: {
                EditButton()
            })
            
        }
    }
}

#Preview {
    ContentView()
}
```
