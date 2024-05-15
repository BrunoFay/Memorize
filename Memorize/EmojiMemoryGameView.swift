import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                .padding(.all)
                .background(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                EmojiCardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.purple)
        
    }
    
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
