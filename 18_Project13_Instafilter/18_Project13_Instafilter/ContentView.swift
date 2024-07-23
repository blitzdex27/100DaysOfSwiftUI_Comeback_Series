//
//  ContentView.swift
//  18_Project13_Instafilter
//
//  Created by Dexter  on 6/25/24.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit

struct ContentView: View {
    @Environment(\.requestReview) private var requestReview
    @AppStorage("filterCount") private var filterCount = 0
 
    @State private var processedImage: Image?
    @State private var pickedPhoto: PhotosPickerItem?
    @State private var selectedFilter: CIFilter = CIFilter.sepiaTone()
    
    @State private var inputImage: CIImage?
    @State private var showingChangeFilter = false
    
    @State private var filterInputDict = [String: Any]()
    
    private var filterInputKeys: [String] {
        selectedFilter.inputKeys.filter({ $0 != kCIInputImageKey })
    }
    
    private let context = CIContext()
        
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $pickedPhoto) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    
                    } else {
                        ContentUnavailableView("No Photo", systemImage: "photo", description: Text("Tap to pick photo"))
                    }
                }
                Spacer()
                Button("Change filter") {
                    showingChangeFilter.toggle()
                }
                .padding()
                .disabled(processedImage == nil)
                
                VStack {
                    if let name = selectedFilter.attributes[kCIAttributeFilterDisplayName] as? String {
                        Text(name)
                            .font(.headline)
                    }
                    
                        
                    ForEach(filterInputKeys, id: \.self) { inputKey in
                        FilterSlider(filter: selectedFilter, name: inputKey, filterInputKey: inputKey) { value, valueVector, key, isVector in
                            filterInputDict[key] = !isVector ? value : valueVector
                            applyProcessing()
                        }
                        Divider()
                    }
                }
                .disabled(processedImage == nil)

                
                if let processedImage {
                    ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                }
            }
            .navigationTitle("Instafilter")
        }
        .padding()
        .onChange(of: pickedPhoto, loadImage)
        .confirmationDialog("Select filter", isPresented: $showingChangeFilter, actions: confirmationDialogAction)
    }
    
    @MainActor @ViewBuilder private func confirmationDialogAction() -> some View {
        Button("Crystallize") { setFilter(CIFilter.crystallize()) }
        Button("Edges") { setFilter(CIFilter.edges()) }
        Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
        Button("Pixellate") { setFilter(CIFilter.pixellate()) }
        Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
        Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
        Button("Vignette") { setFilter(CIFilter.vignette()) }
        Button("Kaleidoscope") { setFilter(CIFilter.kaleidoscope()) }
        Button("Thermal") { setFilter(CIFilter.thermal()) }
        Button("Sharpen Luminance") { setFilter(CIFilter.sharpenLuminance()) }
        Button("Cancel", role: .cancel) { }
    }
    
    @MainActor private func setFilter(_ filter: CIFilter) {
        filterInputDict.removeAll()
        selectedFilter = filter
        applyProcessing()
        
        filterCount += 1
        if filterCount % 5 == 0 && filterCount > 0 {
            requestReview()
        }
    }
    
    private func loadImage() {
        Task {
            guard let pickedPhoto,
                let imageData = try? await pickedPhoto.loadTransferable(type: Data.self),
                let ciImage = CIImage(data: imageData) else {
                return
            }
            inputImage = ciImage
            
            applyProcessing()
        }
    }
    
    private func applyProcessing() {
        selectedFilter.setValue(inputImage, forKey: kCIInputImageKey)
        
        for (key, value) in filterInputDict {
            if let value = value as? CGPoint {
                selectedFilter.setValue(CIVector(cgPoint: value), forKey: key)
            } else {
                selectedFilter.setValue(value, forKey: key)
            }
            
        }
        guard let outputImage = selectedFilter.outputImage,
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        
        let uIImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uIImage)
    }
}

#Preview {
    ContentView()
}
