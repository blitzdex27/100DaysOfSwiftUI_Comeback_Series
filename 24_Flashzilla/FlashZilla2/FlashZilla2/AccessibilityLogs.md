//
//  AccessibilityLogs.md
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//

# Accessibility logs

TLDR;
No need to memorize, just know it exists

```
struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffWithoutColor
    @Environment(\.accessibilityReduceMotion) var reducedMotion
    @Environment(\.accessibilityReduceTransparency) var reducedTransparencyfocus
    
    var body: some View {
        HStack {
            if diffWithoutColor {
                
                Image(systemName: "checkmark.circle")
            }
            Text("Success")
        }
        .padding()
        .background(diffWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.ellipse)
           
    }
}
```
