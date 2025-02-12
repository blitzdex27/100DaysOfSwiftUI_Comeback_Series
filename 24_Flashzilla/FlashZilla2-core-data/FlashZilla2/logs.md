
## simultaneous gesture

```
struct ContentView: View {
    
    @State var currentValue = Angle.zero
    @State var finalValue = Angle.zero
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text Tapped")
                }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded({ _ in
                    print("VStack Tapped")
                })
        )
    }
}

#Preview {
    ContentView()
}
```

## 

```
struct ContentView: View {
    
    @State var currentValue = Angle.zero
    @State var finalValue = Angle.zero
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text Tapped")
                }
        }
        .highPriorityGesture(
            TapGesture()
                .onEnded({ _ in
                    print("VStack Tapped")
                })
        )
    }
}

#Preview {
    ContentView()
}
```

## Sequenced

```
struct ContentView: View {

    @State var translation = CGSize.zero
    @State var translationFinal = CGSize.zero
    
    @State var isDragging = false
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.5)
            .onChanged { isChanged in
                print("xx-->> Long Press changed \(isChanged)")
            }
            .onEnded { value in
                isDragging = true
            }
        let dragGesture = DragGesture()
            .onChanged { value in
                let x = translationFinal.width + value.translation.width
                let y = translationFinal.height + value.translation.height
                translation = CGSize(width: x, height: y)
            }
            .onEnded { value in
                let x = translationFinal.width + value.translation.width
                let y = translationFinal.height + value.translation.height
                translationFinal = CGSize(width: x, height: y)
                isDragging = false
            }
        
        let combined = longPressGesture.sequenced(before: dragGesture)
//        let sequenceGesture = SequenceGesture(longPressGesture, dragGesture)
        Circle()
            .fill(.blue)
            .frame(width: 200, height: 200)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(translation)
            .animation(.bouncy, value: isDragging)
            .animation(.bouncy, value: translation)
            .gesture(combined)
            
    }
}
```
