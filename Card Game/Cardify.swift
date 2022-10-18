//
//  Cardify.swift
//  Card Game
//
//  Created by Macintosh HD on 17/08/2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    
    init(isfaceUp: Bool){
        rotation = isfaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set{ rotation = newValue }
    }
    
    var rotation: Double
    func body(content: Content) -> some View {
        ZStack{
            let shape : RoundedRectangle = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
            shape.fill(
                Color.systemBackground
            )
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.red)
            }
            else {
                shape.fill()
                    .foregroundColor(
                        Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))
                        )
                }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius:CGFloat = 10
        static let lineWidth: CGFloat = 3
        
        
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        
        return self.modifier(Cardify(isfaceUp: isFaceUp))
    }
    
}




