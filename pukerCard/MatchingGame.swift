//
//  MatchingGame.swift
//  pukerCard
//
//  Created by Mickey on 2019/3/15.
//  Copyright © 2019 Mickey. All rights reserved.
//

import Foundation

class MatchingGame {
    
    var cards = [Card]() //var cards : Array(Card)
    var matchCards = [Card]() //暫存卡片 計分邏輯
    
    //初始化 Class emojiTheme
    var emojiChoices = emojiTheme()
    var count : Int = 0
    var addpoint : Int = 0
   
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //更改卡片狀態
    func chooseCard(at index:Int) {
        if !cards[index].isTouched{
            cards[index].isTouched = true
        }
        
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index
                {
                    if cards[matchIndex] == cards[index] {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                    cards[index].isFaceUp = true
            }else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    func matchingCard(at index: Int){
        
        switch matchCards.count {
        case 0:
           matchCards.append(cards[index])
        case 1:
           matchCards.append(cards[index])
           
        case 2 :
            matchCards = []
            matchCards.append(cards[index])
        default:
            break
        }
       print(matchCards)
    }
    
    func calCount(at addCount : Int) -> Int {
        
        switch addCount {
        case 0:
            count = 0
        case 1:
            count += 1
        default:
            break
        }
        return count
    }
    
    func calPoint() -> Int{
        if(matchCards.count == 2){
            if ( matchCards[0].identifier == matchCards[1].identifier ){
                addpoint += 2
            }else{
                matchCards.forEach{ (element) in
                    if(element.isTouched == true){
                        addpoint += -1
                    }
                }
            }
        }
        return addpoint
    }
    
//    func chooseCard(at index : Int){
//
//        if !cards[index].isMatched{
//            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
//                if cards[matchIndex].identifier == cards[index].identifier{
//                    cards[matchIndex].isMatched = true
//                    cards[index].isMatched = true
//                }
//                cards[index].isFaceUp = true
//                //              indexOfOneAndOnlyFaceUpCard = nil
//            }else if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex == index{
//                cards[index].isFaceUp = false
//                indexOfOneAndOnlyFaceUpCard = nil
//            }
//            else{
//                for flipDownIndex in cards.indices {
//                    if !cards[flipDownIndex].isMatched{
//                        cards[flipDownIndex].isFaceUp = false
//                    }
//                }
//                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = index
//            }
//        }
//    }

   
    
    
}

