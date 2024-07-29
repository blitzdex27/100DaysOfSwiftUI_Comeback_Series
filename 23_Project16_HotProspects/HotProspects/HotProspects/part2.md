#  <#Title#>

```
struct ContentView: View {
    @State private var selectedTab = "One"

    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
        .onAppear {
            someTask()
        }
    }
    
    func someTask() {
        let sampleTask = Task {
            let taskOutput = await someLongTask()
            print("someLongTask done")
            return taskOutput
        }
        print("1")
        Task {
            let result = await sampleTask.result
            print("result")
            if let output = try? result.get() {
                print(output)
            }
        }
        print("2")
    }
    
    func someLongTask() async -> String {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                print("0.5")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                print("1")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                print("1.5")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                
                continuation.resume(returning: "Hello")
            })
        }
    }
}

#Preview {
    ContentView()
}

```
