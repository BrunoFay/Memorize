import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    typealias Card = MemoryGame<String>.Card
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                footer
            }
        }.padding()
    }
    
    var footer: some View {
        HStack {
            Text("Score: \(viewModel.score())")
                .animation(nil)
            Spacer()
            deck.foregroundColor(.purple)
            Spacer()
            Button("Shuffle") {
                withAnimation(.easeInOut(duration: 1)){
                    viewModel.shuffle()
                }
            }
            .padding(.all)
            .background(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                if isDealt(card) {
                    EmojiCardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .overlay(FlyingNumber(number: scoreChange(causedByCardId: card)))
                        .zIndex(scoreChange(causedByCardId: card) != 0 ? 100 : 0)
                        .onTapGesture {
                            choose(card)
                        }
                }
            }
        }
        .foregroundColor(.purple)
        
    }
    
    @State var lastScoreChange = (0, causedByCardId: "")
    func scoreChange(causedByCardId card: Card) -> Int {
        let (amount, id) = lastScoreChange
        
        return card.id == id ? amount : 0
    }
    
    private func view(for card: Card) -> some View {
        EmojiCardView(card)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .transition(.asymmetric(insertion: .identity, removal: .identity))
    }

    private func choose(_ card: Card) {
        withAnimation(.easeInOut) {
            let scoreBeforeChosen = viewModel.score()
            viewModel.choose(card)
            let scoreChange = viewModel.score() - scoreBeforeChosen
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                view(for: card)
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
