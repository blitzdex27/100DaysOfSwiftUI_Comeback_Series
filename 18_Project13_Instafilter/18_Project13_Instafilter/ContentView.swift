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
    
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var filterScale = 5.0
    
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
                .disabled(processedImage == nil)
                
                if filterInputKeys.contains(kCIInputIntensityKey) {
                    FilterSlider(selection: $filterIntensity, name: "Intensity", onChange: applyProcessing)
                        .disabled(processedImage == nil)
                }
                
                if filterInputKeys.contains(kCIInputRadiusKey) {
                    FilterSlider(selection: $filterRadius, name: "Radius", onChange: applyProcessing, limits: 0...200)
                        .disabled(processedImage == nil)
                }
                if filterInputKeys.contains(kCIInputScaleKey) {
                    FilterSlider(selection: $filterScale, name: "Scale", onChange: applyProcessing, limits: 0...10)
                        .disabled(processedImage == nil)
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
            selectedFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if filterInputKeys.contains(kCIInputRadiusKey) {
            selectedFilter.setValue(Float(filterRadius), forKey: kCIInputRadiusKey)
        }
        if filterInputKeys.contains(kCIInputScaleKey) {
            selectedFilter.setValue(filterScale, forKey: kCIInputScaleKey)
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
