//
//  MainViewModel.swift
//  Bible Memorization
//
//  Created by Chad Wallace on 2/20/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class Main {
    
    var verse: Verse?
    var verseText: String = "Blank"
    var word: String = ""
    var text: String = ""
    var fixedVerse: String = ""
    var book: String = "John"
    var chapter: String = "3"
    var verseNum: String = "16"
    var displayWords: Bool = false
    var words: [String] = [""]
    var wordList: [Word] = [Word(id: 1, word: "asdf")]
    var wordCounter: Int = 0
    var isInvisible = false
    var vrs: String = ""
    let numVerses = 2
    
    enum catchErrors: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
    init() {
        self.verse = verse
        self.verseText = verseText
        self.word = word
        self.text = text
        self.fixedVerse = fixedVerse
        self.book = book
        self.chapter = chapter
        self.verseNum = verseNum
        self.displayWords = displayWords
        self.words = words
        self.wordList = wordList
        self.wordCounter = wordCounter
        self.isInvisible = isInvisible
        self.vrs = vrs
    }
    
    func getVerse() async throws -> Verse {
        let endpoint = "https://cdn.jsdelivr.net/gh/wldeh/bible-api/bibles/en-kjv/books/john/chapters/3/verses/16.json"
        
        guard let url = URL(string: endpoint) else {
            throw catchErrors.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw catchErrors.invalidResponse
        }
        
        let verseObj = try JSONDecoder().decode(Verse.self, from: data)

        return verseObj
//        do {
//            let decoder = JSONDecoder()
//            return try JSONDecoder().decode(Verse.self, from: data)
            
//        } catch {
//            throw catchErrors.invalidData
//        }
        
    } // end func getVerse
    
    func getWords() async -> [Word]{
        if verseText != "Blank" {
            
            if (verseText.prefix(2) == "¶ ") {
                let fixedVerse = verseText.dropFirst(2)
                verseText = String(fixedVerse)
                words = fixedVerse.components(separatedBy: " ")
            } else if (verseText.prefix(1) == " ")  {
                let fixedVerse = verseText.dropFirst()
                verseText = String(fixedVerse)
                words = fixedVerse.components(separatedBy: " ")
            } else {
                words = verseText.components(separatedBy: " ")
            }
            words.reverse()
            
            wordList.removeAll()
            
            for _ in 1...numVerses {
                for wrdIndex in 0..<words.count {
                    wordList.append(Word(id: 1, word: words[wrdIndex], xPosition: 0.0, yPosition: 0.0, rotation: 0.0))
                }
            }
            for index in 0..<(wordList.count) {
                wordList[index] = Word(id: index, word: wordList[index].word, xPosition: CGFloat.random(in: 50..<330), yPosition: CGFloat.random(in: 40..<300), rotation: Double.random(in: -40.0...40.0))
            }
            
            displayWords = true
            
        } else {
            
            wordList[0] = Word(id: 0, word: "error", xPosition: 0.0, yPosition: 0.0, rotation: 0.0)
        }
     return wordList
    } // end func getWords()
    
       
       func checkButton() {
           
//           if
            
       }
       
    
}
