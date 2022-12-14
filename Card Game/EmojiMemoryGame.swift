//
//  EmojiMemoryGame.swift
//  Card Game
//
//  Created by Macintosh HD on 17/08/2021.
//

import SwiftUI


class emojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
  private static  let Automobile = ["đĄ", "đ", "đł", "đ", "đ", "đ", "đ", "đş", "đ", "đ", "đ", "đ", "đś",
                    "đ", "đ", "đ", "đ˛", "đ´", "đ", "đŚź", "đ¸", "đľ", "đŠź", "đŚ˝"]
    
//    "Automobile", "FaceMoji", "Animal", "Flags", "Sports", "Signs"
    
    private static let FaceMoji = ["đ", "đ", "đ", "đĽ¸", "đ¤", "đ¤Ż", "đ­", "đĽś", "đĽľ", "đĄ", "đŤ ", "đ¤˘", "đ¤Ą",
                      "đ", "đĽ°", "đ", "đĽł", "đśâđŤď¸", "đŤŁ", "đš", "đ˝", "đž", "đş", "đ"]
    
     static  let Animal = ["đ", "đâđŚş", "đ", "đ", "đŚ", "đż", "đŚ", "đŚĄ", "đ", "đ", "đŚŚ", "đ", "đŚŹ",
                      "đŚ", "đ", "đ˘", "đŚ", "đ", "đŚ", "đ", "đŚŁ", "đ", "đŚ", "đŚ"]
    
    private static  let Flags = ["đŹđ§", "đ§đˇ", "đ¨đŚ", "đŚđˇ", "đŚđŽ", "đ´ó §ó ˘ó Ľó Žó §ó ż", "đšđŠ", "đŠđ°", "đŹđŞ", "đŠđŞ", "đŻđ˛", "đŻđľ", "đłđŹ",
                      "đ¸đŞ", "đťđŞ", "đŞđ¸", "đ°đˇ", "đ¨đŽ", "đąđˇ", "đ¨đ­", "đťđŞ", "đšđš", "đšđ´", "đ´ó §ó ˘ó ˇó Źó łó ż"]
    
    private static  let Sports = ["â˝ď¸", "đ", "đ", "đ§", "đž", "đŻ", "đ", "đ¤˝ââď¸", "đŁââď¸", "đââď¸", "đš", "đĽ", "đ",
                      "đź", "đĽ", "đ´", "đ", "đĽ", "đŞ", "đ", "đł", "đ§Š", "đą", "đŽ"]
    
    private static  let Signs = ["đ", "â­", "đś", "đŽ", "đ§", "â", "đ­", "đł", "đ", "â", "âŽď¸", "âď¸", "đ",
                      "đ", "đ", "đ˘", "â¸", "âśď¸", "âş", "â", "â", "â", "âď¸", "đ˛"]
    
     static  let Foods = ["đ", "đ", "đ", "đ", "đ", "đĽĽ", "đś", "đ˝", "đĽ", "đ", "đ", "đ", "đ",
                      "đŚ", "đĽ", "đ§", "đĄ", "đŠ", "đż", "đĽ", "âď¸", "đĽ", "đŽ", "đĽŞ"]
    
    
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



