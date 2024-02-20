//
//  ContentView.swift
//  Bible Memorization
//
//  Created by Chad Wallace on 2/18/24.
//

import SwiftUI
import Observation

struct ContentView: View {
    
    @State var vrs = Verse()
    @State var fixedVerse: String = ""
    @State var book: String = "John"
    @State var chapter: String = "3"
    @State var verseNum: String = "16"
    @State var displayWords: Bool = false
    @State var words: [String] = [""]
    
    var body: some View {
        
        VStack{
            Text("Today's Verse")
                .font(.title)
                .foregroundColor(.blue)
            Text("")
            Text("\(book) \(chapter):\(verseNum)")
                .font(.headline)
            Text("")
            Text(vrs.text)
                .multilineTextAlignment(.leading)
                .font(.headline)
            Text("")
            

                ZStack{
                    if displayWords == true{
                    
                    ForEach(1..<5) {index in
                        ForEach(words, id: \.self) { word in
                            Button(action: {
                                
                            }, label: {
                                Text(word)
                            })
                            .buttonStyle(.borderedProminent)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 3))
                            .rotationEffect(Angle(degrees: Double.random(in: -40.0...40.0)))
                            .position(x: CGFloat.random(in: 50..<320), y:CGFloat.random(in: 40..<300))
                        }
                    }
                } // end ZStack
            } // end if DisplayWords
        } // end VSTack
        .task {
            do {
                vrs = try await getVerse()
                getWords()
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
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(Verse.self, from: data)
            } catch {
                throw catchErrors.invalidData
            }
        } // end func getVerse
        
        func getWords() {
            if (vrs.text.prefix(2) == "¶ ") {
                var fixedVerse = vrs.text.dropFirst(2)
                vrs.text = String(fixedVerse)
                words = fixedVerse.components(separatedBy: " ")
            } else if (vrs.text[vrs.text.startIndex] == " ") {
                let fixedVerse = vrs.text.dropFirst()
                vrs.text = String(fixedVerse)
                words = fixedVerse.components(separatedBy: " ")
            } else {
                words = vrs.text.components(separatedBy: " ")
            }
            words.reverse()
            displayWords = true
        } // end func getWords()
    } // end contentView
    
    
    
    #Preview {
        ContentView(book:"John", chapter: "3", verseNum: "16")
    }
    
    struct Verse: Codable {
        var verse: String = ""
        var text: String = ""
    }
    
    enum catchErrors: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
