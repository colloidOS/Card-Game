//
//  EmojiMemoryGame.swift
//  Card Game
//
//  Created by Macintosh HD on 17/08/2021.
//

import SwiftUI


class emojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
  private static  let Automobile = ["🚡", "🚂", "🛳", "🚙", "🚎", "🚚", "🏍", "🛺", "🚜", "🚍", "🚀", "🚁", "🛶",
                    "🛟", "🚔", "🛞", "🚲", "🛴", "🚑", "🦼", "🛸", "🛵", "🩼", "🦽"]
    
//    "Automobile", "FaceMoji", "Animal", "Flags", "Sports", "Signs"
    
    private static let FaceMoji = ["😂", "😍", "😝", "🥸", "🤓", "🤯", "😭", "🥶", "🥵", "😡", "🫠", "🤢", "🤡",
                      "💀", "🥰", "😇", "🥳", "😶‍🌫️", "🫣", "😹", "👽", "👾", "👺", "🎃"]
    
     static  let Animal = ["🐈", "🐕‍🦺", "🐇", "🐀", "🦔", "🐿", "🦝", "🦡", "🐖", "🐄", "🦦", "🐒", "🦬",
                      "🦍", "🐅", "🐢", "🦓", "🐓", "🦒", "🐜", "🦣", "🐑", "🦓", "🦘"]
    
    private static  let Flags = ["🇬🇧", "🇧🇷", "🇨🇦", "🇦🇷", "🇦🇮", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇹🇩", "🇩🇰", "🇬🇪", "🇩🇪", "🇯🇲", "🇯🇵", "🇳🇬",
                      "🇸🇪", "🇻🇪", "🇪🇸", "🇰🇷", "🇨🇮", "🇱🇷", "🇨🇭", "🇻🇪", "🇹🇹", "🇹🇴", "🏴󠁧󠁢󠁷󠁬󠁳󠁿"]
    
    private static  let Sports = ["⚽️", "🏀", "🏈", "🧗", "🎾", "🎯", "🏑", "🤽‍♂️", "🚣‍♀️", "🏄‍♂️", "🛹", "🥏", "🏓",
                      "🛼", "🥌", "🚴", "🏇", "🥊", "🪁", "🛝", "🎳", "🧩", "🎱", "🎮"]
    
    private static  let Signs = ["🔇", "⏭", "📶", "🚮", "🏧", "✅", "🚭", "🚳", "🔞", "❌", "☮️", "✝️", "🛐",
                      "🆚", "🆘", "💢", "⏸", "▶️", "⏺", "➕", "➖", "➗", "✖️", "💲"]
    
     static  let Foods = ["🍏", "🍌", "🍇", "🍉", "🍓", "🥥", "🌶", "🌽", "🥕", "🎂", "🍗", "🍔", "🍕",
                      "🍦", "🥒", "🧀", "🍡", "🍩", "🍿", "🥜", "☕️", "🥘", "🌮", "🥪"]
    
    
     static  var emojis = Automobile
    
//    [Automobile, FaceMoji, Animal, Flags, Sports, Signs, Foods]
    
    
    
    
   private  static func createMemoryGame()  -> MemoryGame<String> {
        
        MemoryGame<String>(numberOfPairsOfCards: 10)
        { pairIndex in emojis[pairIndex] }
        
        
    }
   
   @Published private  var model = createMemoryGame()
   
    var cards : Array<Card> {
        return model.cards
        
    }
//    MARK: Intent
    func choose(_ card: Card) {
       
        model.choose(card)
    }
    
    func Shuffle(){
        model.Shuffle()
    }
    
    func restart() {
        model = emojiMemoryGame.createMemoryGame()
    }
    
    
}



