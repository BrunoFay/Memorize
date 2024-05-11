//
//  MemoryGame.swift
//  Memorize
//
//  Created by bruno alves fay on 10/05/24.
//

import Foundation

struct MemoryGame<CarContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CarContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairOfCards){
            cards.append(Card(content: cardContentFactory(pairIndex)))
            cards.append(Card(content: cardContentFactory(pairIndex)))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CarContent
        
    }
}
