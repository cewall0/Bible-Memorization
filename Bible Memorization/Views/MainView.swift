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
    @State private var verseState: Verse?
    @State private var wrdList: [Word] = [Word(id: 1, word: "wrdLst")]
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
            
//            Text(main.verseText)
//                .multilineTextAlignment(.leading)
//                .font(.headline)
//                .padding()
//            Text("")
            
            Text(verseState?.text ?? "verseState empty")
                .multilineTextAlignment(.leading)
                .font(.headline)
                .padding()
            Text("")
            if main.displayWords == true {
                Text(String(main.wordList[18].id))
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .padding()
            }
            Text("")
            if main.displayWords == true {
                Text(String(buttonID))
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .padding()
            }
            
            
            Text("")
        
                ZStack{
                    if main.displayWords == true {
                    
                        ForEach(main.wordList, id: \.id) { word in
                            Button(action: {
                                self.buttonID = word.id
//                                main.checkButton()
                            }, label: {
                                Text(String(word.id))
                            })
                            .buttonStyle(.borderedProminent)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 3))
                            .rotationEffect(Angle(degrees: word.rotation))
                            .position(x: word.xPosition, y: word.yPosition)
//                            .frame(height: main.isInvisible ? nil : 0)
//                            .disabled(main.isInvisible)
                        } // end ForEach
                    } // end if
                } // end ZStack
            
            Spacer()
            
        } // end VSTack
        .task {
            do {
                
            verseState = try await main.getVerse()
//            main.verseText = verseState?.text ?? "default value verseZero"
            wrdList = await main.getWords()
                
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
