
```
struct ContentView: View {
    
    @State var currentValue = Angle.zero
    @State var finalValue = Angle.zero
    
    var body: some View {
        Text("Hello, world!")
            .rotationEffect(currentValue)
            .gesture(RotateGesture()
                .onChanged({ value in
                    currentValue = finalValue + value.rotation
                    print("value.rotation: \(value.rotation)")
                })
                    .onEnded({ value in
                        finalValue = currentValue
                    })
            )
    }
}

#Preview {
    ContentView()
}
```
