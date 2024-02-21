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
    var xPosition: CGFloat = 0.0
    var yPosition: CGFloat = 0.0
    var rotation: Double = 0.0
}
