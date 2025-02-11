//
//  EditCardView.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/8/25.
//

import SwiftUI
import SwiftData

struct EditCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Environment(\.cardStore) var cardStore
    @State var newPrompt = ""
    @State var newAnswer = ""
    
    @State var selection = Set<CardV2>()
    @State var editMode: EditMode = .inactive
    
    @FocusState var isPromptFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                List(selection: $selection) {
                    Section("Add new card") {
                        TextField("Prompt", text: $newPrompt)
                            .focused($isPromptFocused)
                        TextField("Answer", text: $newAnswer)
                        Button("Add card", action: addCard)
                    }
                    Section("Cards") {
                        ForEach(cardStore.cards.reversed()) { card in
                            VStack(alignment: .leading) {
                                Text(card.question)
                                    .font(.headline)
                                Text(card.answer)
                                    .foregroundStyle(.secondary)
                            }
                            .tag(card)
                        }
                        .onDelete(perform: cardStore.removeCard)
                    }
                }
                .onSubmit(addCard)
                if !selection.isEmpty {
                    Button("Delete selected", action: deleteSelected)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar(content: {
                Button("Done", action: done)
                EditButton()
            })
            .animation(.default, value: cardStore.cards)
            .environment(\.editMode, $editMode)
        }
    }
    
    func addCard() {
        let trimmmedPrompt = newPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmmedPrompt.isEmpty,
              !trimmedAnswer.isEmpty else {
            return
        }
        let card = CardV2(prompt: newPrompt, answer: newAnswer)
        cardStore.addCard(card)
        clearFields()
        isPromptFocused = true
    }
    
    func deleteSelected() {
        cardStore.removeCards(selection)
    }
    
    func done() {
        dismiss()
    }
    

    /// Challenge: When adding a card, the text fields keep their current text. Fix that so that the textfields clear themselves after a card is added.
    func clearFields() {
        newPrompt = ""
        newAnswer = ""
    }
}

#Preview {
    EditCardView()
}
