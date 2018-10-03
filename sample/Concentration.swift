//
//  Concentration.swift
//  sample
//
//  Created by João Graça on 02/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var facedUpCardIndex: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let lastIndex = facedUpCardIndex, lastIndex != index {
                if cards[lastIndex].identifier == cards[index].identifier {
                    cards[lastIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                facedUpCardIndex = nil
            } else {
                for newIndex in cards.indices {
                    cards[newIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                facedUpCardIndex = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            /*cards.append(card)
            cards.append(card)*/
        }
        cards.shuffle()
    }
}
