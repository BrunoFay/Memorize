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
        TimelineView(.animation) { timeline in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    let base = RoundedRectangle(cornerRadius: 12)
                    Group {
                        base.fill(.white)
                        base.strokeBorder(lineWidth: 2)
                        Text(card.content)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.01)
                            .aspectRatio(1, contentMode: .fit)
                            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                            .animation(.spin(duration: 1), value: card.isMatched)
                        
                    }
                    .font(.largeTitle)
                    .opacity(card.isFaceUp ? 1 : 0)
                    base.fill().opacity(card.isFaceUp ? 0 : 1)
                }
                .opacity(card.isMatched ? 0 : 1)
                .rotation3DEffect(.degrees(card.isFaceUp ? 0 : 180),axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
            }
            else {
                Color.clear
            }
        }
    }
    
    
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

#Preview {
    EmojiCardView(MemoryGame<String>.Card(content: "B", id: "test11"))
}
