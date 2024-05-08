import SwiftUI

struct ContentView: View {
    @State var icons: [String] = ["🐙", "🪼", "🦞", "🦀","🐬","🐳","🦈","🦬","🦭","🐘"]
    @State var cardsQuantity = 3
    
    var body: some View {
        VStack {
            cards
            Spacer()
            actionsButtons
        }.padding()
    }
    
    var cards: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                
                ForEach(0..<cardsQuantity, id: \.self) { index in
                    CardView(content: icons[index])
                        .aspectRatio(2/3,contentMode: .fit)
                }
                
            }
            .foregroundColor(.purple)
        }
    }
    
    var actionsButtons: some View {
        HStack{
            incrementActionButton(icon: "rectangle.stack.fill.badge.plus", by: 1)
            Spacer()
            incrementActionButton(icon: "rectangle.stack.fill.badge.minus", by: -1)
        }
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        
        
    }
    
    func incrementActionButton(icon: String, by value: Int) -> some View {
        Button {
            cardsQuantity += value
        } label: {
            Image(systemName: icon)
        }
        .disabled(cardsQuantity + value > icons.count || cardsQuantity + value < 1)
    }
}

struct CardView: View {
    @State var isFaceUp = false
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                
            }
            .font(.largeTitle)
            .opacity(isFaceUp ? 0 : 1)
            base.fill().opacity(isFaceUp ? 1 : 0)
        }
        .onTapGesture{
            isFaceUp.toggle()
        }
        
    }
}

#Preview {
    ContentView()
}
