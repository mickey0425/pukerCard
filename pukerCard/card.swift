//
//  card.swift
//  pukerCard
//
//  Created by Mickey on 2019/3/15.
//  Copyright © 2019 Mickey. All rights reserved.
//

import Foundation

struct Card : Hashable{
    var hashValue: Int {
        return identifier
    }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var isTouched = false
    var identifier:Int
    
    
    static var  identifierFactory = 0
    static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }

}




class emojiTheme {
    var Animals = "🐸🐧🐝🐼🦋🦕🦑🦍"
    var Faces = "🤬😤💀👺😭🤡😎🤖"
    var Foods = "🍌🍟🍔🍤🍣🍖🍉🥗"
    var Sports = "⚽️🏀🎾🏸🏓🎱🚴🏻‍♂️🏊🏻‍♀️"
    var Countries = "🇹🇼🇯🇵🇧🇪🇮🇸🇨🇦🇦🇷🇺🇸🇰🇷"
    var Plants = "🌻🍄🌵🌹🍀🌴🌳🎋"
}





















