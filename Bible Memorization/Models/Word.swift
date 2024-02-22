//
//  Word.swift
//  Bible Memorization
//
//  Created by Chad Wallace on 2/21/24.
//

import Foundation
import Observation

struct Word: Identifiable, Codable, Hashable {
    var id: Int = 0
    var word: String = "empty word string"
    var xPosition: CGFloat = CGFloat.random(in: 50..<330)
    var yPosition: CGFloat = CGFloat.random(in: 40..<300)
    var rotation: Double = Double.random(in: -40.0...40.0)
    var isInvisible = false

}
