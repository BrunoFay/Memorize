import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                HStack {
                    Text("Score: \(viewModel.score())")
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
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                EmojiCardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.choose(card)                            
                        }
                    }
            }
        }
        .foregroundColor(.purple)
        
    }
    
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
