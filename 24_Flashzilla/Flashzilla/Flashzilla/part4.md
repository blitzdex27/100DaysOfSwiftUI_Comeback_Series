#  <#Title#>

```
struct ContentView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    let timer = Timer.publish(every: 1, tolerance: 2, on: .main, in: .common).autoconnect()
    
    @State var counter = 0
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("Hello")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped!")
        }
        .onAppear {
            
        }
        .onReceive(timer) { output in
            if counter >= 5 {
                timer.upstream.connect().cancel()
            }
            counter += 1
            print(output)
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .background:
                print("background")
            case .inactive:
                print("inactive")
            case .active:
                print("active")
            }
        }
    }
```
