//
//  card.swift
//  pukerCard
//
//  Created by Mickey on 2019/3/15.
//  Copyright © 2019 Mickey. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier  : Int      //use ID , not emoji
    static var  identifierFactory = 0
    static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}





