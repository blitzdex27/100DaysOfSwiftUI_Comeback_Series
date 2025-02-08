//
//  EditCardView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/8/25.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.dismiss) var dismiss
    @State var cards = [Card]()
    @State var newPrompt = ""
    @State var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                Section("Cards") {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCard)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar(content: {
                Button("Done", action: done)
            })
            .onAppear(perform: loadData)
        }
    }
    
    func removeCard(_ offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func addCard() {
        let trimmmedPrompt = newPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmmedPrompt.isEmpty,
              !trimmedAnswer.isEmpty else {
            return
        }
        let card = Card(prompt: newPrompt, answer: newAnswer)
        cards.insert(card, at: 0)
        saveData()
    }
    
    func done() {
        dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            do {
                let decoded = try JSONDecoder().decode([Card].self, from: data)
                cards = decoded
            } catch {
                
            }
            
        }
    }
    
    func saveData() {

        
        do {
            let encoded = try JSONEncoder().encode(cards)
            UserDefaults.standard.set(encoded, forKey: "Cards")
        } catch {
            
        }
    }
}

#Preview {
    EditCardView()
}
