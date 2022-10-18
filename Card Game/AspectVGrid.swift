//
//  AspectVGrid.swift
//  Card Game
//
//  Created by Macintosh HD on 17/08/2021.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var Items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
     
    init(Items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.Items = Items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    
    
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(ItemCount: Items.count, in: geometry.size, itemAspectRatio: aspectRatio)
        LazyVGrid(columns: [adaptiveGridItem(width: width) ], spacing: 0) {
            ForEach(Items) { item in
                content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
            }
            Spacer(minLength: 0)
            }
            
        }
        
        
    }
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
        }

    private func widthThatFits(ItemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = ItemCount
        repeat{
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat (rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (ItemCount + (columnCount - 1)) / columnCount
        } while columnCount < ItemCount
        if columnCount > ItemCount {
            columnCount = ItemCount
        }
        return floor(size.width / CGFloat(columnCount))
        
        
        
    }
    
    
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
  
