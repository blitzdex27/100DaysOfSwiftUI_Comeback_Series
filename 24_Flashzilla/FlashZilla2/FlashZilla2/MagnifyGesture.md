
```
struct ContentView: View {
    
    @State var currentValue: CGFloat = 1
    @State var finalValue: CGFloat = 1
    
    var body: some View {
        Text("Hello, world!")
            .scaleEffect(currentValue)
            .gesture(MagnifyGesture()
                .onChanged { value in
                    print("magnification: \(value.magnification)")
                    currentValue = value.magnification * finalValue
                }
                .onEnded { value in
                    finalValue = currentValue
                    
                }
            )
            
    }
}

#Preview {
    ContentView()
}
```
