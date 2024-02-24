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
    
    var verseText: String = "blank"
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
    var allClicked = false
    
    
    enum catchErrors: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
    
    
    func getVerse() async {
        let endpoint = "https://cdn.jsdelivr.net/gh/wldeh/bible-api/bibles/en-kjv/books/john/chapters/3/verses/16.json"
        
        guard let url = URL(string: endpoint) else {
            print("Error with returning url from: \(endpoint)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Verse.self, from: data) else {
                print("JSON Error: could not decode returned data.")
                return
            }
            self.verseText = returned.text
            self.wordList = getWords()
        } catch {
            print("Error: Could not use URL to get data and response")
        }
        
        
        
    } // end func getVerse
    
    func getWords()  -> [Word] {
        
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
        
        for vrsIndex in 1...numVerses {
            for wrdIndex in 0..<words.count {
                wordList.append(Word(id: 1, word: words[wrdIndex], xPosition: CGFloat.random(in: 50..<330), yPosition: CGFloat.random(in: 40..<300), rotation: Double.random(in: -40.0...40.0), isInvisible: false, color: vrsIndex))
            }
        }
        
        for index in 0..<(wordList.count) {
            wordList[index] = Word(id: index, word: wordList[index].word, xPosition: wordList[index].xPosition, yPosition: wordList[index].yPosition, rotation: wordList[index].rotation, color: wordList[index].color)
        }
        
        wordCounter = wordList.count - 1
        displayWords = true
        
        
        return wordList
        
    } // end func getWords()
    
    func myColor(intColor: Int) -> Color {
        let color = intColor
        switch color {
            case 1:
                return .cyan
            case 2:
                return .blue
            case 3:
                return .red
            case 4:
                return .green
            case 5:
                return .indigo
            default:
                return .white
            }
        }
    
    func checkAllClicked() {
        if wordCounter == 0 {
            allClicked = true
        }
    }
    
    }

