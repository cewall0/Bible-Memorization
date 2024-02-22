//
//  MainView.swift
//  Bible Memorization
//
//  Created by Chad Wallace on 2/18/24.
//

import SwiftUI
import Observation

struct MainView: View {
    
    @Bindable var main = Main()
//    @State private var verseState: Verse?
    @State private var buttonID: Int = 0
    @State private var toDelete: Int = 0
    
    enum catchErrors: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
    var body: some View {
        
        VStack{
            
            Text("Today's Verse")
                .font(.title)
                .foregroundColor(.blue)
            Text("")
            Text("\(main.book) \(main.chapter):\(main.verseNum)")
                .font(.headline)
            Text("")
            
            Text(main.verseText)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .padding()
            Text("")
            
//            Text(verseState?.text ?? "verseState empty")
//                .multilineTextAlignment(.leading)
//                .font(.headline)
//                .padding()
//            Text("")
            
//            if main.displayWords == true {
//                Text(String(main.wordCounter))
//                    .multilineTextAlignment(.leading)
//                    .font(.headline)
//                    .padding()
//            }
//            Text("")
//            if main.displayWords == true {
//                Text(String(buttonID))
//                    .multilineTextAlignment(.leading)
//                    .font(.headline)
//                    .padding()
//            }
            
            
            Text("")
        
                ZStack{
                    if main.displayWords == true {
                    
                        ForEach(main.wordList, id: \.id) { word in
                            Button(action: {
                                if word.id == main.wordCounter {
                                   main.wordList[word.id].isInvisible = true
                                    main.wordCounter -= 1
                                } else {
                                    main.wordList[word.id].isInvisible = false
                                }
                                
                            }, label: {
                                Text(String(word.word))
                            })
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 3)).opacity(main.wordList[word.id].isInvisible ? 0.0 : 1.0)
                            .rotationEffect(Angle(degrees: main.wordList[word.id].rotation))
                            .position(x: main.wordList[word.id].xPosition, y: main.wordList[word.id].yPosition)
                            .buttonStyle(.borderedProminent)
//                            .frame(height: main.wordList[word.id].isInvisible ? nil : 0)
                            .disabled(main.wordList[word.id].isInvisible)
                        } // end ForEach
                    } // end if
                } // end ZStack
            
            Spacer()
            
        } // end VSTack
        .task {
            do {
                
//                verseState = try await main.getWords().
//            main.verseText = verseState?.text ?? "default value verseZero"
            main.wordList = try await main.getWords()
                
            } catch catchErrors.invalidURL {
                print("invalid URL")
            } catch catchErrors.invalidResponse {
                print("invalid response")
            } catch catchErrors.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }
        } // end task
    
    }// end View Body
    
    } // end contentView
    
    #Preview {
        MainView()
    }
    
    




//if (verse.text.prefix(2) == "¶ ") {
//    let fixedVerse = verse.text.dropFirst(2)
//    verse.text = String(fixedVerse)
//    words = fixedVerse.components(separatedBy: " ")
//} else if (verse.text.prefix(1) == " ")  {
//    let fixedVerse = verse.text.dropFirst()
//    verse.text = String(fixedVerse)
//    words = fixedVerse.components(separatedBy: " ")
//} else {
//    words = verse.text.components(separatedBy: " ")
//}
//words.reverse()
//
//displayWords = true
