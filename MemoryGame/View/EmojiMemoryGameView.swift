//
//  EmojiMemoryGameView.swift
//  MemoryGame
//
//  Created by Kate Sychenko on 28.04.2022.
//

import SwiftUI
import Foundation

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State private var dealt = Set<Int>()
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                header
                Divider()
                gameBody
                Spacer()
                bottomView
            }
            deckBody
                
        }
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
        //  .previewDevice("iPhone 12 mini")
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
        // .previewDevice("iPhone 12 mini")
    }
}


extension EmojiMemoryGameView {
    
    private var header: some View {
        VStack {
            Text(viewModel.theme.name)
                .font(.largeTitle)
            score
        }
    }
    
    private var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                //      .transition(AnyTransition.scale.animation(Animation.easeInOut(duration: 2)))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card)
                        }
                    }
            }
        }
        
        .foregroundColor(viewModel.cardBackgroundColor) // Here theme's background card color goes
        
    }
    
    private var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndealt)) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(viewModel.cardBackgroundColor) // Here theme's background card color goes
        .onTapGesture {
            for card in viewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    private var bottomView: some View {
    
        HStack(alignment: .center) {
                shuffleButton
                Spacer()
                newGameButton
            }


        .font(.title3)
        .padding()
    }
    
    private var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }


    }
    
    private var newGameButton: some View {
        Button("Start over")  {
            withAnimation {
                dealt = []
                viewModel.newGame()
            }
        }

    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
    }
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id
        }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(viewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.totalDealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private struct CardConstants {
        static let color = Color.accentColor
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
    }
}

