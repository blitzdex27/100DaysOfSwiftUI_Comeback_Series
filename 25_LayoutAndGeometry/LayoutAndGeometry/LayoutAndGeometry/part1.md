#  <#Title#>

```
        VStack(alignment: .leading) {
            ForEach(0..<20) { num in
                Text("Number \(num)")
                    .alignmentGuide(.leading, computeValue: { dimension in
                        CGFloat(num * -10)
                    })
            }
         }
         .background(.red)
         .frame(width: 400, height: 400)
         .background(.blue)
```

```
struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                Text("@twostraws")
                Image(.paulHudson)
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .font(.largeTitle)
            }
        }
    }
}
```
