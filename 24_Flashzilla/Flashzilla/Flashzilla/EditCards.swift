//
//  EditCards.swift
//  Flashzilla
//
//  Created by Dexter  on 8/8/24.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    
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
            .onAppear(perform: loadData)
        }
    }
    
    func removeCards(_ indexSet: IndexSet) {
        cards.remove(atOffsets: indexSet)
        save()
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
        
        cards.insert(card, at: 0)
        save()
        resetFields()
    }
    
    func save() {
        CardStore.saveCards(cards)
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func loadData() {
        cards = CardStore.loadData()
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
