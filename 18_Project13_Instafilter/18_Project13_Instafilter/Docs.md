struct ContentView: View {
    @State private var image: Image?
    @State private var filter: CIFilter?
    
    private let filters: [CIFilter] = [
        CIFilter.colorInvert(),
        CIFilter.sepiaTone(),
        CIFilter.areaAverage(),
        CIFilter.pixellate()
    ]
    
    var inputFilterKeys: [String]? {
        guard let filter = filter else {
            return nil
        }
        
        var inputFilterKeys = [String]()
        for inputKey in filter.inputKeys {
            if inputKey != kCIInputImageKey {
                inputFilterKeys.append(inputKey)
            }
        }
        
        return inputFilterKeys
    }
    
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                
                Picker("Select filter", selection: $filter) {
                    ForEach(filters, id: \.self) { filter in
                        Text(filter.name)
                            .tag(filters.first(where: {$0 == filter}))
                    }
                    
                }
                
                if let inputFilters = inputFilterKeys {
                    List(inputFilters, id: \.self) { filter in
                        Text(filter)
                        
                    }
                }
            } else {
                ContentUnavailableView("Unavailable", systemImage: "swift")
            }
        }
        .onAppear(perform: loadImage)
//        .onChange(of: filter ?? .affineTile()) { oldValue, newValue in
//            print("xx-->> filter: \(newValue.name)")
//        }
        .onChange(of: filter ?? .affineTile(), initial: true) { oldValue, newValue in
            print("xx-->> filter: \(newValue.name)")
        }
    }
    
    func loadImage() {
        image = Image(.topupDialogBg)
        return
        let inputImage = UIImage(resource: .topupDialogBg)
        let beginImage = CIImage(image: inputImage)
        
//        let filter = CIFilter.sepiaTone()
//        filter.intensity = 1
//        filter.inputImage = beginImage
        
//        let filter = CIFilter.pixellate()
//        filter.inputImage = beginImage
//        filter.scale = 100
        
        let filter = CIFilter.twirlDistortion()
        filter.inputImage = beginImage
        filter.radius = 1000
        filter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        
        
        guard let outputImage = filter.outputImage else {
            return
        }
        
        let context = CIContext()
        
       
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        
       let uiImage = UIImage(cgImage: cgImage)
        
        
//        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
