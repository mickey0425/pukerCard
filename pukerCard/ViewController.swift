//
//  ViewController.swift
//  pukerCard
//
//  Created by Mickey on 2019/3/8.
//  Copyright © 2019 Mickey. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet var cardbutton: [UIButton]!
    
    lazy var game:MatchingGame =  MatchingGame(numberOfPairsOfCards: numberOfPairsCard)
    
    var numberOfPairsCard: Int{
        return (cardbutton.count+1)/2
    }
    
    var count:Int = 0
    {
        didSet{
            countLabel.text = "count: \(count)"
        }
    }
    
    var emojiChoise = ["🃏","💀","🔞","💩","🧠","🐷","🦋","🐝"]
    var emoji = Dictionary<Int,String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardbutton.index(of: sender){
            print("cardNumber = \(String(describing: cardNumber))")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("not in the collection")
        }
        count += 1
    }
    
    func updateViewFromModel(){
        for index in cardbutton.indices {
            let button = cardbutton[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for : card),for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                if card.isMatched{
                    button.setTitle(emoji(for : card),for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 0.6469659675)
                }else{
                    button.setTitle("",for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                }
            }
        }
    }
    
    
    func emoji(for card: Card)-> String {
        print(card.identifier)
        if emoji[card.identifier] == nil , emojiChoise.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoise.count)))
            emoji[card.identifier] = emojiChoise.remove(at: randomIndex)
        print(emojiChoise)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func resetCard(_ sender: Any) {
        
        emojiChoise = ["🃏","💀","🔞","💩","🧠","🐷","🦋","🐝"]
        emoji = Dictionary<Int,String>()
        
        for i in cardbutton.indices{
          game.initCard(at: i)
          cardbutton[i].setTitle("",for: UIControl.State.normal)
          cardbutton[i].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        count = 0
    }
}
