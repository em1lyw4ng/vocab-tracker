//
//  Deck.swift
//  Vocab Tracker
//
//  Created by Emily on 3/28/22.
//

import Foundation

struct Deck {
    var title: String
}

extension Deck {
    static let sampleData: [Deck] =
    [
        Deck(title: "Beginner"),
        Deck(title: "Intermediate"),
        Deck(title: "Advanced"),
    ]
}
