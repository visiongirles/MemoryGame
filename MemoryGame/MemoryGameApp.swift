//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by Kate Sychenko on 28.04.2022.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
