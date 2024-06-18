#  Day 50

struct ContentView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if let error = phase.error {
                Text("Error")
            } else {
                ProgressView() 
            }
        }
    }
}

## Haptics

```
import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var count = 0
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Tap for success", action: complexSuccess)
        .onAppear(perform: prepareHaptics)
        
        
    }
    
    func prepareHaptics() {
        guard isHapticEngineCapable else {
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Cannot start CHHapticEngine")
        }
    }
    
    func complexSuccess() {
        guard isHapticEngineCapable else {
            return
        }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Unable to play haptics")
        }
        
    }
    
    var isHapticEngineCapable: Bool {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }
}

```



## Order cupcake
```

import SwiftUI

struct ContentView: View {
    @State var order: Order
    
    var body: some View {
        List{
            Picker("Cupcake", selection: $order.type) {
                ForEach(Order.options.indices, id: \.self) { index in
                    Text(Order.options[index])
                }
            }
            
            Stepper("Quantity:  \(order.count)", value: $order.count, in: 2...12)
            
            Section {
                Toggle("Special requests", isOn: $order.hasSpecialRequest)
                
                if order.hasSpecialRequest {
                    Toggle("Add extra frost", isOn: $order.addExtraFrosting)
                    Toggle("Add sprinkles", isOn: $order.addSprinkles)
                }
            }
        }
    }
}

```
