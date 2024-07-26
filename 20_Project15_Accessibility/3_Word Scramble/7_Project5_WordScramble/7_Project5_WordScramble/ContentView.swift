//
//  ContentView.swift
//  7_Project5_WordScramble
//
//  Created by Dexter Ramos on 3/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var newWord: String = ""
    @State private var usedWords = [String]()
    @State private var rootWord: String = ""
    
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var isShowAlert: Bool = false
    
    @State private var currentPoints: Int = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(currentPoints, format: .number)
                } header: {
                    Text("Current points")
                }
                Section {
                    TextField("Enter word here...", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(word), \(word.count) letters")
                    }
                }
            }
            .onSubmit(addWord)
            .navigationTitle(rootWord)
            .onAppear(perform:startGame)
            .alert(errorTitle, isPresented: $isShowAlert) { } message: {
                Text(errorMessage)
            }
            .toolbar(content: {
                Button("start game") {
                    startGame()
                }
            })
        }
    }
    
    func addWord() {
        let inputWord = self.newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard composedOfCharactersGreaterThanOrEqual(to: 3, for: inputWord) else {
            wordError(title: "Word character count insufficient", message: "You need to provide at least 3 character-word")
            return
        }
        
        guard !isSameWithStarterWord(word: inputWord) else {
            wordError(title: "Unacceptable!", message: "Should not be the same with the starter word.")
            return
        }
        
        guard isOriginal(word: inputWord) else {
            wordError(title: "Word has been used already", message: "Choose another word!")
            return
        }
        
        guard isPossible(word: inputWord) else {
            wordError(title: "Word not possible", message: "You cannot spell that word from '\(rootWord)'")
            return
        }
        
        guard isReal(word: inputWord) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        
        withAnimation {
            usedWords.insert(inputWord, at: 0)
            self.newWord = ""
            currentPoints += calculatePoints(word: inputWord)
        }
        
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            do {
                let startWordsString =  try String(contentsOf: startWordsURL)
                let startWords = startWordsString.components(separatedBy: "\n")
                rootWord = startWords.randomElement() ?? "silkworm"
                usedWords.removeAll()
                newWord = ""
                currentPoints = 0
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Unable to load start.txt")
        }
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.count)
        let result = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: true, language: "en")
        return result.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        isShowAlert = true
    }
    
    func isSameWithStarterWord(word: String) -> Bool {
        rootWord == word
    }
    
    func composedOfCharactersGreaterThanOrEqual(to minCharCount: Int, for word: String) -> Bool {
        word.count >= minCharCount
    }
    
    func calculatePoints(word: String) -> Int {
        return word.count * usedWords.count
    }
}

#Preview {
    ContentView()
}
