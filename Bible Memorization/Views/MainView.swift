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
            

            
            Text("")
        
            if main.allClicked == false {

                ZStack{
                    if main.displayWords == true {
                    
                        ForEach(main.wordList, id: \.id) { word in
                            Button(action: {
                                if word.id == main.wordCounter {
                                   main.wordList[word.id].isInvisible = true
                                    main.wordCounter -= 1
                                    main.checkAllClicked()
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
                            .buttonStyle(.borderedProminent).tint(main.myColor(intColor: main.wordList[word.id].color))
//                            .frame(height: main.wordList[word.id].isInvisible ? nil : 0)
                            .disabled(main.wordList[word.id].isInvisible)
                        } // end ForEach
                    } // end if
                } // end ZStack
            } else {// end if
                VStack{
                    Text("Well Done!")
                        .font(.title)
                        .foregroundColor(.blue)
                    
                    // reset the clicking game.
                    Button {
                        main.allClicked = false
                    } label: {
                        Text("Go again?")
                    }.buttonStyle(.borderedProminent)

                }
            }
            
            Spacer()
            
        } // end VSTack
        .task {
            await main.getVerse()
        } // end task
    
    }// end View Body
    
    } // end contentView
    
    #Preview {
        MainView()
    }

