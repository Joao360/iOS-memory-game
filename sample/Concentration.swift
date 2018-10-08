//
//  Concentration.swift
//  sample
//
//  Created by João Graça on 02/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    foundIndex = index
//                } else {
//                    return nil
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let lastIndex = indexOfTheOneAndOnlyFaceUpCard, lastIndex != index {
                if cards[lastIndex] == cards[index] {
                    cards[lastIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): numberOfPairsOfCards should be greater than 0")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            /*cards.append(card)
            cards.append(card)*/
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
