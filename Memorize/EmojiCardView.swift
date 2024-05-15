//
//  EmojiCardView.swift
//  Memorize
//
//  Created by bruno alves fay on 14/05/24.
//

import SwiftUI

struct EmojiCardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                
            }
            .font(.largeTitle)
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched ? 0 : 1 )
    }
    
    
}

#Preview {
    EmojiCardView(MemoryGame<String>.Card(content: "B", id: "test11"))
}
