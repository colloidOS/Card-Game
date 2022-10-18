//
//  FirstView.swift
//  Card Game
//
//  Created by Macintosh HD on 17/08/2021.
//

import SwiftUI

struct FirstView: View {
    private let game = emojiMemoryGame()
    var EmojiType = ["Automobile", "Animal", "FaceMoji", "Flags", "Foods", "Signs", "Sports"]
    @State var selectedEmoji : String? = ""
//    @State var selectedEmoji1 : String? = nil
     @State var selectionIndex = 0
    @State var OverlayNumber = 1.0
    
    var body: some View {
//        WindowGroup {
//        NavigationView {
            ZStack{
//                Color.cyan
                
                
                
                LinearGradient(gradient: Gradient(colors: [
                 
                    Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),
                    Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                Text("Welcome To The Emoji Game")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))).shadow(radius: 10, x: 0, y: 5)
                        
                    )
                    
                        .font(.title2)
                        .padding()
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        
                
                VStack {
                VStack(alignment: .center) {
//                    HStack(alignment: .center){
                Text("Emoji Type")
                        .foregroundColor(.black)
                        .padding()
                        
                    
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
                                .shadow(radius: 5)
                            
                        )
                        .padding(.top)
                        
                    
                    VStack {
                        TextFieldWithInputView(data: self.EmojiType, placeholder: "Select the emoji type", selectionIndex: self.$selectionIndex, selectedText: self.$selectedEmoji)
                            .foregroundColor(.white)
                            .padding(.leading)
                                .frame(width: 300, height: 50)
                        
//                        if selectedText == selectedEmoji[0] {
//                            game.emojis = game.Automobile
//                        }
                            
                         }
                    

//                    Picker("Select The Emoji Type", selection: $selectedEmoji) {
//                                    ForEach(EmojiType, id: \.self) {
//                                        Text($0)
//                        }
//                        }
//                    .frame(alignment: .center)
                    .background(Color.systemBackground)
                    .cornerRadius(10)
//                    .pickerStyle(.wheel)
                
                    
                    

                    
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))).shadow(radius: 10, x: 0, y: 5)
                        
                    )
                }
//                    .padding()
//                    .padding()
//                    .padding()
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            NavigationLink{
            EmojiMemoryGameView(game: game)
            }
        label: {
            Text("Start")
                .font(.title2)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .padding(12)
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
                    .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .scaleEffect(OverlayNumber)
                    .opacity(1.5 - OverlayNumber)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: OverlayNumber)
                
                
                
                    .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                    )
                    .shadow(radius: 10)
                )
                .padding()
                .padding()
        }
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
        }
            

            .onAppear{
                    OverlayNumber = 1.5
            }
//            .accentColor(.primary)
        
        
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FirstView()
            FirstView()
                .preferredColorScheme(.dark)
        }
    }
}




