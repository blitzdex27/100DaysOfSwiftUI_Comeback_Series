# ``LayoutAndGeometry``

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### Alignment guide

```
struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Text1")
                .background(.yellow)
                .alignmentGuide(.leading) { d in
                    d.width / 2
                }
                .padding()
                .background(.green)
            Text("Text2")
        }
        .background(.red)
        .frame(width: 300, height: 300)
        .background(.blue)
    }
}
```

### Custom Alignment guide

```
extension VerticalAlignment {
    enum Text1AndText4Alignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let text1AndText4Aligment = VerticalAlignment(Text1AndText4Alignment.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .text1AndText4Aligment) {
            VStack {
                Text("Text1")
                    .alignmentGuide(.text1AndText4Aligment) { d in
                        d[VerticalAlignment.center]
                    }
                Text("Text2")
                    .font(.largeTitle)
            }
            
            VStack {
                Text("Text3")
                Text("Text4")
                    .font(.largeTitle)
                    .alignmentGuide(.text1AndText4Aligment) { d in
                        d[VerticalAlignment.center]
                    }
            }
        }
    }
}
```

### Coordinate Space

```
struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { g in
                Text("Center")
                    .frame(width: g.size.width, height: g.size.height)
                    .background(.blue)
                    .onTapGesture {
                        let globalCoords = g.frame(in: .global)
                        print("Global center: \(globalCoords.midX) x \(globalCoords.midY)")
                        let localCoords = g.frame(in: .local)
                        print("Local center: \(localCoords.midX) x \(localCoords.midY)")
                        let outerCoords = g.frame(in: .named("Outer"))
                        print("Outer center: \(outerCoords.midX) x \(outerCoords.midY)")
                    }
                    
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct ContentView: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(NamedCoordinateSpace.named("Outer"))
    }
}

```

### Scrolling geometry 

```
struct ContentView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50, id: \.self) { index in
                    GeometryReader { proxy in
                        Text("Row \(index)")
                            .font(.title)
                            .frame(width: proxy.size.width)
                            .background(colors[index % colors.count])
                            .rotation3DEffect(
                                .degrees(
                                    (proxy.frame(in: .global).minY - fullView.size.height / 2) / 5.0
                                ),
                                axis: (x: 0, y: 1, z: 0)
                            )
                        
                    }
                    .frame(height: 40)
                }
            }
        }
        .coordinateSpace(NamedCoordinateSpace.named("ContentView"))
        
        
    }
}
```

```
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { proxy in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}
```

### Visual Effect

```
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .frame(width: 200, height: 200)
                            .visualEffect { content, proxy in
                                content
                                    .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            }
                            
                    }
                    .frame(width: 200, height: 200)
            }
        }
    }
}
```

### Scroll target

```
struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .frame(width: 200, height: 200)
                            .visualEffect { content, proxy in
                                content
                                    .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            }
              
                    }
                    .frame(width: 200, height: 200)
            }
            .scrollTargetLayout()
            
        }
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
    }
}
```
