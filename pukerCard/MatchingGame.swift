//
//  MatchingGame.swift
//  pukerCard
//
//  Created by Mickey on 2019/3/15.
//  Copyright © 2019 Mickey. All rights reserved.
//

import Foundation

class MatchingGame {
    
    var cards = [Card]()
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            
            cards.append(card)
            cards.append(card)
            //           -> cards += [card, card]
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
        set{                                 //Default: newValue
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index : Int){
       
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                   cards[matchIndex].isMatched = true
                   cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
//              indexOfOneAndOnlyFaceUpCard = nil
            }else if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex == index{
                cards[index].isFaceUp = false
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                for flipDownIndex in cards.indices {
                    if !cards[flipDownIndex].isMatched{
                        cards[flipDownIndex].isFaceUp = false
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
         }
    }
    
    func initCard(at index : Int){
        cards[index].isFaceUp = false
        cards[index].isMatched = false
        
    }
    
    
}
