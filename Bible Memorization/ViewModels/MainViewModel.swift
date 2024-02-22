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
    
//    var verse: Verse?
    var verseText: String = "blank"
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
    let numVerses = 5
    var toDelete = 0
    var wordID = 0
    
    enum catchErrors: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
    init() {
//        self.verse = verse
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
        self.wordID = wordID
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

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Verse.self, from: data)
            
        } catch {
            throw catchErrors.invalidData
        }
        
    } // end func getVerse
    
    func getWords() async throws -> [Word] {
        do{
            try await verseText = getVerse().text
        } catch {
            throw catchErrors.invalidData
        }
//        if verseText != "Blank" {
//            
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
                    wordList.append(Word(id: 1, word: words[wrdIndex], xPosition: CGFloat.random(in: 50..<330), yPosition: CGFloat.random(in: 40..<300), rotation: Double.random(in: -40.0...40.0), isInvisible: false))
                }
            }

            for index in 0..<(wordList.count) {
                wordList[index] = Word(id: index, word: wordList[index].word, xPosition: wordList[index].xPosition, yPosition: wordList[index].yPosition, rotation: wordList[index].rotation)
            }
            
            wordCounter = wordList.count - 1
            displayWords = true
            
//        } else {
//            
//            wordList[0] = Word(id: 0, word: "error", xPosition: 0.0, yPosition: 0.0, rotation: 0.0, isInvisible: false)
//        }
        return wordList
        
    } // end func getWords()
    
//    func getData() async {
//        wordList = (try? await getWords()) ?? []
//    }
       
//    func checkButton(buttonID: Int) -> Bool {
//           isInvisible = false
//        if buttonID == wordCounter {
//            wordCounter -= 1
//            return true
//        } else {
//            return false
//        }
//       }
       
    
}
