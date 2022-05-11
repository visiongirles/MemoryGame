//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Kate Sychenko on 28.04.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    
    //closure as variable
    private(set) var theme: Theme = {
        return Constant.allThemes.randomElement() ?? Constant.animalsTheme
    }()
    
    var gradientForCardBackground: LinearGradient? {
        switch cardBackgroundColor {
        case Color.blue: return LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
        default: return nil
        }
    }
    
    var cardBackgroundColor: Color {
        switch theme.cardBackgroundColor {
        case "black": return Color.black
        case "green": return Color.green
        case "pink": return Color.pink
        case "orange": return Color.orange
        case "red": return Color.red
        case "brown": return Color.brown
        case "blue": return Color.blue
        case "gray": return Color.gray
        default: return Color.yellow
        }
        //        return Color(theme.cardBackgroundColor)
        // return UIColor(named: theme.cardBackgroundColor) ?? UIColor.yellow
    }
    
    // we make computed property so others can have an read access only
    var cards: Array<Card> {
        model.cards
    }
    var score: Int {
        model.score
    }
    
    private static func createMemoryGame(from theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in theme.emojies[pairIndex] }
    }
    
    // NEED REFACTOR AND THINK: init and newGame()
    
    init() {
        self.model = EmojiMemoryGame.createMemoryGame(from: self.theme)
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame() {
        self.theme = Constant.allThemes.randomElement() ?? Constant.animalsTheme
        self.model = EmojiMemoryGame.createMemoryGame(from: self.theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
}

