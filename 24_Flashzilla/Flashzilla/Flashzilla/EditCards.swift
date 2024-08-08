//
//  EditCards.swift
//  Flashzilla
//
//  Created by Dexter  on 8/8/24.
//

import SwiftUI
import SwiftData

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query private var cards: [Card]
    
    @State var newPrompt: String = ""
    @State var newAnswer: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }
                ForEach(cards) { card in
                    VStack(alignment: .leading) {
                        Text(card.prompt)
                            .font(.headline)
                        Text(card.answer)
                            .foregroundStyle(.secondary)
                    }
                }
                .onDelete(perform: removeCards(_:))
                
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    
    func removeCards(_ indexSet: IndexSet) {
        
        var cardsToRemove = indexSet.map({ cards[$0] })
        
        cardsToRemove.forEach({ modelContext.delete($0) })
    }
    
    func addCard() {
        
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(
            id: UUID(),
            prompt: newPrompt,
            answer: newAnswer
        )
        
        modelContext.insert(card)
        resetFields()
    }
    
    func save() {
        CardStore.saveCards(cards)
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func done() {
        dismiss()
    }
    
    func resetFields() {
        newPrompt = ""
        newAnswer = ""
    }
}

#Preview {
    EditCards()
}
