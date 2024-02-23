//
//  ContentView.swift
//  Retry_Project3
//
//  Created by Dexter Ramos on 2/23/24.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)

        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, column in
            Text("[\(row),\(column)]")
                .font(.monospaced(.body)())
            Image(systemName: "\(row * 4 + column).circle")
        }
    }
}

#Preview {
    ContentView()
}
