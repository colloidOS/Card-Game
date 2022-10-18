//
//  EmojiMemoryGameView.swift
//  Card Game
//
//  Created by Macintosh HD on 17/08/2021.
//

import SwiftUI

struct EmojiMemoryGameView : View {
   @ObservedObject var game : emojiMemoryGame
    @Namespace private var dealingNamespace
//   @State var emojiCount = 24
    var body: some View {
     
        ZStack(alignment: .bottom) {
            Color.red
                .opacity(0.5)
                .ignoresSafeArea()
            VStack{
                
                GameBody
                
//                    .padding(.bottom)
                HStack {
                    Spacer()
                    shuffle
                    Spacer()
                    Spacer()
                    Spacer()
                    restart
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            deckBody
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
//                .padding(.bottom)
        }
        
        
        
      
                    
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal (_ card: emojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: emojiMemoryGame.Card) -> Bool{
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: emojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: emojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
    var GameBody: some View {
        AspectVGrid(Items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of: card))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.7)){
            game.choose(card)
            }
            }
     }
  }
       
        
        .foregroundColor(CardConstants.color)
    }
    
        var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)){ card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)

                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
            
        .onTapGesture{
            for card in game.cards {
            withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    
    var shuffle : some View {
        Button{
            withAnimation(.easeInOut(duration: 1)){
            game.Shuffle()
        }
        }
    label: {
           Text("Shuffle")
            .foregroundColor(.primary)
            .font(.title3)
            .padding(12)
            .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.red)
                .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 3)
                
                .foregroundColor(.orange)
                )
            )
        }
    }
    
    var restart : some View{
        Button{
            withAnimation {
                dealt = []
                game.restart()
            }
        } label: {
            Text("Restart")
                .foregroundColor(.primary)
                .font(.title3)
                .padding(12)
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                    .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                    
                    .foregroundColor(.cyan)
                    )
                )
                
        }
        
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
        
    }
    
    }
    


struct CardView : View {
    let card : emojiMemoryGame.Card
    @State private var animatedBonusRemaining: Double = 0
//    @State var cardify : Cardify
//    var content: String
//    @State private var animationAmount = 1.0
    var body: some View {
        GeometryReader  { geometry in
            ZStack{
                
                Group{
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees:  (1 - animatedBonusRemaining) * 360 - 90))
                    
                        .onAppear{
                            animatedBonusRemaining = card.bonusRemaining
                            withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                animatedBonusRemaining = 0
                            }
                        }
                } else {
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees:  (1 - card.bonusRemaining) * 360 - 90))
                }
            }
                .padding(5)
                .opacity(0.5)
               
                    Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360: 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
               }
            .foregroundColor(Color.red)
            .cardify(isFaceUp: card.isFaceUp)
           }
        
     }
    
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
         }
    
    
    
    
   
    private struct DrawingConstants {

        static let fontScale: CGFloat = 0.65
        static let fontSize: CGFloat = 32
        
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = emojiMemoryGame()
        Group {
            EmojiMemoryGameView(game: game)
//            EmojiMemoryGameView(game: game)
//                .preferredColorScheme(.dark)
        }
    }
}







