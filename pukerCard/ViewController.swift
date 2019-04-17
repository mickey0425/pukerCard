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
    
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet var cardbutton: [UIButton]!
    
    var flipAllCount = 0
    var themeTopic = ["Animals","Faces","Foods","Sports","Countries","Plants"]
    
    var emojiChoises = ["","","","","","","",""]
    var emojiChoise: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        theme = themeTopic[Int(arc4random_uniform(UInt32(themeTopic.count)))]
        
        switch theme {
        case "Animals":
            emojiChoise = game.emojiChoises.Animals
            break
        case "Faces":
            emojiChoise = game.emojiChoises.Faces
            break
        case "Foods":
            emojiChoise = game.emojiChoises.Foods
            break
        case "Sports":
            emojiChoise = game.emojiChoises.Sports
            break
        case "Countries":
            emojiChoise = game.emojiChoises.Countries
            break
        case "Plants":
            emojiChoise = game.emojiChoises.Plants
            break
            
        default:
           break
        }
        print(emojiChoise)
    }
    
    
    
    lazy var game:MatchingGame =  MatchingGame(numberOfPairsOfCards: numberOfPairsCard)
    
    
    var numberOfPairsCard: Int{
        return (cardbutton.count+1)/2
    }
     
    
    
    var theme : String = ""
    {
        didSet{
            themeLabel.text = " Theme : \(theme) "
        }
    }
    
    var count:Int = 0
    {
        didSet{
            countLabel.text = "count: \(count)"
        }
    }
    
   
    
    
    
    
    var emoji = Dictionary<Int,String>()
    
    lazy var cardId = Array(1...cardbutton.count)
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
    
        if let cardNumber = cardbutton.index(of: sender){
            print("cardNumber = \(String(describing: cardNumber))")
            
            let card = game.cards[cardNumber]
            if !card.isMatched {
                count = game.calCount(at: 1)
                //                count += 1
            }
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        }else{
            print("not in the collection")
        }
        
        
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
        
        if emoji[card.identifier] == nil , emojiChoises.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
            emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func resetCard(_ sender: Any) {
        
        
        emojiChoises = ["","","","","","","",""]

        emoji = Dictionary<Int,String>()
        
        for i in cardbutton.indices{
            
            game.cards[i].isFaceUp = false
            game.cards[i].isMatched = false
            
            let randomIndex = Int(arc4random_uniform(UInt32(cardId.count)))
            print(cardId[randomIndex])
            game.cards[i].identifier = (cardId[randomIndex]+1)/2
            cardId.remove(at: randomIndex)
            print(cardId)
            cardbutton[i].setTitle("",for: UIControl.State.normal)
            cardbutton[i].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        print(game.cards)
        //        count = 0
        count = game.calCount(at: 0)
        cardId = Array(1...cardbutton.count)
        flipAllCount = 0
    }
    
    
    @IBAction func flipAll(_ sender: Any) {
        print(flipAllCount%2)
        switch  flipAllCount%2 {
            
        case 0:
            for index in cardbutton.indices {
                game.cards[index].isFaceUp = true
                game.cards[index].isMatched = true
            }
            flipAllCount += 1
        case 1:
            for index in cardbutton.indices {
                game.cards[index].isFaceUp = false
                game.cards[index].isMatched = false
            }
            flipAllCount += 1
        default:
            break
        }
        
        updateViewFromModel()
        //        count = 0
        count =  game.calCount(at: 0)
    }
}
