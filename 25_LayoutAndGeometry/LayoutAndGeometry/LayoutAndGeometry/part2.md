#  <#Title#>

```swift

fileprivate extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
    

}

fileprivate extension HorizontalAlignment {
    enum CenterAccountAndAvatar: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.leading]
        }
        
        
    }
    
    static let centerAccountAndAvatar = HorizontalAlignment(CenterAccountAndAvatar.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack(alignment: .centerAccountAndAvatar) {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName, computeValue: { d in
                        d[VerticalAlignment.center]
                    })
                Image(.paulHudson)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .alignmentGuide(.centerAccountAndAvatar, computeValue: { d in
                        d[HorizontalAlignment.center]
                    })
                    
 
            }
            
            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .font(.largeTitle)
                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
            }

        }
        .background(.red)
    }
}
```
