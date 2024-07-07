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
    @State private var filterIntensity = 0.5
//    @State private var filterValues = [String: Double]()
    
    @State private var inputImage: CIImage?
    @State private var showingChangeFilter = false
    
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
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                
                if let processedImage {
                    ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                }
            }
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
        Button("Cancel", role: .cancel) { }
    }
    
    @MainActor private func setFilter(_ filter: CIFilter) {
        
        selectedFilter = filter
        applyProcessing()
        
        filterCount += 1
        if filterCount % 5 == 0 && filterCount > 0 {
            requestReview()
        }
    }
    
    private func loadImage() {
        Task {
            guard let pickedPhoto else {
                return
            }
            
            guard let imageData = try? await pickedPhoto.loadTransferable(type: Data.self) else {
                return
            }
            
            guard let ciImage = CIImage(data: imageData) else {
                return
            }
            
            inputImage = ciImage
            
            applyProcessing()
        }
    }
    
    private func applyProcessing() {
        selectedFilter.setValue(inputImage, forKey: kCIInputImageKey)
        
        if filterInputKeys.contains(kCIInputIntensityKey) {
            selectedFilter.setValue(Float(filterIntensity), forKey: kCIInputIntensityKey)
        }
        if filterInputKeys.contains(kCIInputRadiusKey) {
            selectedFilter.setValue(Float(filterIntensity * 200), forKey: kCIInputRadiusKey)
        }
        if filterInputKeys.contains(kCIInputScaleKey) {
            selectedFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        guard let outputImage = selectedFilter.outputImage else {
            return
        }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        
        let uIImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uIImage)
    }
}

#Preview {
    ContentView()
}
