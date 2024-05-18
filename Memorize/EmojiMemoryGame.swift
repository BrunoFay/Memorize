
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static private let icons = ["🐙", "🪼", "🦞", "🦀","🐬","🐳","🦈","🦬","🦭","🐘"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairOfCards: 7) { pairIndex in
            if icons.indices.contains(pairIndex){
                return icons[pairIndex]
            } else {
                return "run"
            }
        }
    }
    
    @Published private var memoryGameModel = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return memoryGameModel.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        return memoryGameModel.choose(card)
    }
    
    func shuffle() {
        memoryGameModel.shuffle()
    }
    
    func score() -> Int {
        return memoryGameModel.score
    }
}

