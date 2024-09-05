#  <#Title#>

```
struct ContentView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row \(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height/2) / 5,
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
            
        
    }
}



base

```
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<100) { index in
                    GeometryReader { proxy in
                        Text("Number \(index)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .frame(width: 200, height: 200)
                            .rotation3DEffect(
                                .degrees(-proxy.frame(in: .global).minX / 8),
                                axis: (0, 1, 0)
                            )
                            .background(.blue)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}
```


```

visual effect

```
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<100) { index in
                        Text("Number \(index)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .frame(width: 200, height: 200)
               
                            .background(.blue)
                            .visualEffect { content, proxy in
                                content
                                    .rotation3DEffect(
                                        .degrees(-proxy.frame(in: .global).minX / 8),
                                        axis: (0, 1, 0)
                                    )
                            }
                    
                }
            }
        }
    }
}
```

target behavior

```
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<100) { index in
                        Text("Number \(index)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .frame(width: 200, height: 200)
                            .visualEffect { content, proxy in
                                content
                                    .rotation3DEffect(
                                        .degrees(-proxy.frame(in: .global).minX / 8),
                                        axis: (0, 1, 0)
                                    )
                            }
                    
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}
```
