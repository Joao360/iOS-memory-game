//
//  ViewController.swift
//  sample
//
//  Created by João Graça on 01/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction private func onMapClick(_ sender: UIButton) {
        performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    @IBOutlet private weak var flipLabel: UILabel! {
        didSet {
            updateFlipLabel()
        }
    }
    
    private func updateFlipLabel() {
        //flipLabel.text = "Flips: \(flips)"
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flips)", attributes: attributes)
        flipLabel.attributedText = attributedString
    }
    
    private(set) var flips = 0 {
        didSet {
            updateFlipLabel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func onNewGame() {
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
        flips = 0
        identifiers = ViewController.defaultIdentifiers
        updateViewOnModel()
    }
    
    @IBAction private func onPressButton(_ sender: UIButton) {
        flips += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewOnModel()
        } else {
            print("Button not found on cardsButton")
        }
    }
    
    private func updateViewOnModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.backgroundColor = .white
                button.setTitle(identifier(for: card), for: .normal)
            } else {
                button.backgroundColor = card.isMatched ? .clear : .orange
                button.setTitle("", for: .normal)
            }
        }
    }
    
    private static let defaultIdentifiers = "ABCDEF"
    private var identifiers = defaultIdentifiers
    private var cardIdentifiers = [Card:String]()
    
    private func identifier(for card: Card) -> String {
        if cardIdentifiers[card] == nil, identifiers.count > 0 {
            let stringIndex = identifiers.index(identifiers.startIndex, offsetBy: Int.random(in: 0..<identifiers.count))
            cardIdentifiers[card] = String(identifiers.remove(at: stringIndex))
        }
        
        return cardIdentifiers[card] ?? "?"
    }

}

