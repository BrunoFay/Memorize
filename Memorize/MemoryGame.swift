//
//  MemoryGame.swift
//  Memorize
//
//  Created by bruno alves fay on 10/05/24.
//

import Foundation

struct MemoryGame<CarContent> where CarContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score: Int = 0
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CarContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairOfCards){
            cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)A"))
            cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)B"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        updateScore(with: 2)
                    }
                    else {
                        updateScore(with: -1)
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func updateScore(with value: Int) {
        score += value
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CarContent
        
        var id: String
        
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
