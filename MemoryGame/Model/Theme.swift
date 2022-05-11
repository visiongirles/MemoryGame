//
//  Theme.swift
//  MemoryGame
//
//  Created by Kate Sychenko on 28.04.2022.
//

import Foundation
import SwiftUI

struct Theme {
    let name: String
    let emojies: [String]
    let numberOfPairsOfCards: Int
    let cardBackgroundColor: String
    
    // pair only in one Theme - no dublicates
    
    init(name: String, emojies: [String], numberOfPairsOfCards: Int, cardBackgroundColor: String) {
        self.name = name
        self.emojies = Array(Set(emojies))
        self.numberOfPairsOfCards = min(numberOfPairsOfCards, self.emojies.count)
        self.cardBackgroundColor = cardBackgroundColor
    }
    
    //extra #1
    init(name: String, emojies: [String], cardBackgroundColor: String) {
        self.name = name
        self.emojies = Array(Set(emojies))
        self.numberOfPairsOfCards = emojies.count
        self.cardBackgroundColor = cardBackgroundColor
    }
    
}

struct Constant {
    static let allThemes = [blackTheme, halloweenTheme, loveTheme, symbolsTheme, girlsTheme, sportTheme, animalsTheme, flagsTheme]
    
    static let blackTheme = Theme(name: "Black Theme",
                                  emojies: ["🖤", "🖤","🌑","🎱","🥷🏿","🧛🏿‍♀️","🎓"],
                                  numberOfPairsOfCards: 4,
                                  cardBackgroundColor: "black")
    static let halloweenTheme = Theme(name: "Halloween Theme",
                                  emojies: ["👻","🧟‍♀️","🧙‍♂️","🦇","🕷","🕸","🔮","🎃"],
                                  numberOfPairsOfCards: 8,
                                  cardBackgroundColor: "orange")
    static let loveTheme = Theme(name: "Love Theme",
                                  emojies: ["👩‍❤️‍👨","🌈","💕","💖","🎎","💝","❣️","❤️","❤️‍🔥","💟"],
                                 numberOfPairsOfCards: Int.random(in: 3...8),
                                 cardBackgroundColor: "pink")
    static let symbolsTheme = Theme(name: "Symbols Theme",
                                  emojies: ["❌","‼️","❓","⛔️","⭕️","🆘","♨️","➕","➖","➗","✖️","💲","✔️","™️","💱","☑️","🔝"],
                                  numberOfPairsOfCards: 5,
                                  cardBackgroundColor: "red")
    static let girlsTheme = Theme(name: "Girls Theme",
                                  emojies: ["👩🏻‍🦱","🧟‍♀️","👩🏽","👵🏽","🧑‍🦰","👧🏼","🧕🏽","🧑🏼‍🎤","👩🏿‍🔧"],
                                  numberOfPairsOfCards: 9,
                                  cardBackgroundColor: "blue")
    static let sportTheme = Theme(name: "Sport Theme",
                                  emojies: ["⚽️","🏀","🏈","⚾️","🥎","🏐","🏉","🥏","🪀","🏓","🏑","🥅","🛼","⛸","🥌","🥊"],
                                  numberOfPairsOfCards: Int.random(in: 3...16),
                                  cardBackgroundColor: "brown")
    static let animalsTheme = Theme(name: "Animal Theme",
                                  emojies: ["🐶", "🐹", "🦊", "🐻", "🐷", "🐝", "🦆", "🦁", "🦄", "🦉", "🦋", "🐴", "🐸", "🐧"],
                                  numberOfPairsOfCards: 6,
                                  cardBackgroundColor: "green")
    static let flagsTheme = Theme(name: "Flag Theme",
                                  emojies: ["🇧🇩", "🇦🇲", "🇦🇿", "🏳️‍🌈", "🇧🇮", "🇨🇮", "🇨🇫", "🇧🇲", "🇨🇦", "🇮🇴"],
                                  numberOfPairsOfCards: 5,
                                  cardBackgroundColor: "gray")
}


