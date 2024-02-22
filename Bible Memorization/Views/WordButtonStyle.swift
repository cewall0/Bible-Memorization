//
//  WordButtonStyle.swift
//  Bible Memorization
//
//  Created by Chad Wallace on 2/22/24.
//

import Foundation
import SwiftUI

struct WordButtonStyle: ButtonStyle {

    let main = Main()
    let wordIndex: Int
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
//            .padding()
//            .background(Color(.blue)).opacity(main.wordList[wordIndex].isInvisible ? 0.0 : 1.0)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.black, lineWidth: 3)).opacity(main.wordList[wordIndex].isInvisible ? 0.0 : 1.0)
//            .frame(height: main.wordList[wordIndex].isInvisible ? nil : 0)
//            .rotationEffect(Angle(degrees: main.wordList[wordIndex].rotation))
//            .position(x: main.wordList[wordIndex].xPosition, y: main.wordList[wordIndex].yPosition)
//            .disabled(main.wordList[wordIndex].isInvisible)
    }
}
