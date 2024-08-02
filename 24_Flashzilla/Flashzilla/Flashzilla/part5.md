#  Accessibility

## Differentiate without color
```
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)
    }
}
```

## reduce motion 
```
struct ContentView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0

    var body: some View {
        Button("Hello, World!") {
            if reduceMotion {
                scale *= 1.5
            } else {
                withAnimation {
                    scale *= 1.5
                }
            }

        }
        .scaleEffect(scale)
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}
```

## Reduced transparency

```
struct ContentView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}
```
