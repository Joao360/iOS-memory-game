//
//  ViewController.swift
//  sample
//
//  Created by João Graça on 01/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func onMapClick(_ sender: UIButton) {
        performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    @IBOutlet weak var flipLabel: UILabel!
    
    var flips = 0 {
        didSet {
            flipLabel.text = "Flips: \(flips)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func onNewGame() {
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
        flips = 0
        identifiers = ViewController.defaultIdentifiers
        updateViewOnModel()
    }
    
    @IBAction func onPressButton(_ sender: UIButton) {
        flips += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewOnModel()
        } else {
            print("Button not found on cardsButton")
        }
    }
    
    func updateViewOnModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.backgroundColor = UIColor.white
                button.setTitle(identifier(for: card), for: UIControl.State.normal)
            } else {
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
                button.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    static let defaultIdentifiers = ["A", "B", "C", "D", "E", "F"]
    var identifiers = defaultIdentifiers
    var cardIdentifiers = [Int:String]()
    
    func identifier(for card: Card) -> String {
        if cardIdentifiers[card.identifier] == nil, identifiers.count > 0 {
            cardIdentifiers[card.identifier] = identifiers.remove(at: Int.random(in: 0..<identifiers.count))
        }
        
        return cardIdentifiers[card.identifier] ?? "?"
    }

}

