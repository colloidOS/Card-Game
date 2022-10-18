//
//  MemoryGame.swift
//  Card Game
//
//  Created by Macintosh HD on 17/08/2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
   private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFacedUpCard : Int? {
    get { cards.indices.filter({ cards[$0].isFaceUp }).OneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
}
    
   mutating func choose (_ card: Card) {
   
       if  let chosenIndex = cards.firstIndex(where: {$0.id == card.id }),

            !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
     {
           if let potentialMatchIndex = indexOfTheOneAndOnlyFacedUpCard {
               if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                   cards[chosenIndex].isMatched = true
                   cards[potentialMatchIndex].isMatched = true
           }
               cards[chosenIndex].isFaceUp = true
 
           } else {
               
               indexOfTheOneAndOnlyFacedUpCard = chosenIndex
           }
          
           
        
       }
    
      
    }
    
    mutating func Shuffle(){
        cards.shuffle()
    }
    
    
    
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
     cards = []
//        add numberOfPairsOfCards X 2 cards to cards array
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
       
        
        var isFaceUp = false {
            didSet{
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int
        
        
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpdate = self.lastFaceUpdate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpdate)
            } else {
                return pastFaceUpTime
            }
        }
        
        
        var lastFaceUpdate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpdate == nil {
                lastFaceUpdate = Date()
            }
        }
       
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpdate = nil
        }
        
        
    }
    
}



extension Array {
    var OneAndOnly: Element? {
        
        if count == 1 {
            return first
        }
        else {
            return nil
        }
    }
    
}
