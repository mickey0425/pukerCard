//
//  ViewController.swift
//  pukerCard
//
//  Created by Mickey on 2019/3/8.
//  Copyright © 2019 Mickey. All rights reserved.
//
import UIKit

extension Int{
    var arc4random:Int{
        if self>0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self<0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else{
            return 0 }
    } }

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomEmojiTheme()
        
        
    }
    
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet var cardbutton: [UIButton]!
    
    @IBOutlet weak var pointLabel: UILabel!
    
    
    
    
    //點擊filpALL 次數
    var flipAllCount = 0
    
    
    var themeTopic = ["Animals","Faces","Foods","Sports","Countries","Plants"]
   
    var emojiChoices: String = ""

    
    //    var emoji = Dictionary<Int,String>()
    var emojiDic = [Card:String]()
    
    lazy var cardId = Array(1...cardbutton.count)
    
    
    
    //初始化game 來調用 matchingGame.swift中模組 並傳入卡片編號numberOfPairsOfCards
    lazy var game:MatchingGame =  MatchingGame(numberOfPairsOfCards: numberOfPairsCard)
    
    var numberOfPairsCard: Int{
        return (cardbutton.count+1)/2
    }
     
    //當前卡片emoji主題
    var theme : String = ""
    {
        didSet{
            themeLabel.text = " Theme : \(theme) "
        }
    }
    
    //點及卡片次數
    var count:Int = 0
    {
        didSet{
            countLabel.text = "count : \(count)"
        }
    }
    
    //遊戲分數
    var point: Int = 0
    {
        didSet{
            pointLabel.text = "point : \(point)"
        }
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardbutton.index(of: sender){
            print("cardNumber = \(String(describing: cardNumber))")
            
            let card = game.cards[cardNumber]
            print(card)
            
            if !card.isMatched  {
                if(game.matchCards.count == 1 && card.isFaceUp ){
                    print("It's the same card")
                }else{
                    game.matchingCard(at: cardNumber)
                }
                point = game.calPoint()
                count = game.calCount(at: 1)
            }
        
            game.chooseCard(at: cardNumber)
            
//            if !card.isMatched{
//               count = game.calCount(at: 1)
//            }
            
            updateViewFromModel()
            
            
        }else{
            print("not in the collection")
        }
    }
    
    //更新所有卡片畫面
    func updateViewFromModel(){
        for index in cardbutton.indices {
            let button = cardbutton[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(getEmoji(for : card),for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }else{
                if card.isMatched{
                    button.setTitle(getEmoji(for : card),for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 0.6469659675)
                }else{
                    button.setTitle("",for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                }
            }
        }
    }
    
    private func getEmoji(for card: Card)-> String {
        
        if emojiDic[card] == nil , emojiChoices.count > 0 {
            
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emojiDic[card] = String(emojiChoices.remove(at:randomStringIndex))
        }
        return emojiDic[card] ?? "?"
        
    }

    @IBAction func resetCard(_ sender: Any) {
        
//        emojiChoices = ["","","","","","","",""]
//        emoji = Dictionary<Int,String>()
        
        randomEmojiTheme()
        emojiDic = [Card:String]()
        
        for i in cardbutton.indices{
            
            game.cards[i].isFaceUp = false
            game.cards[i].isMatched = false
            game.cards[i].isTouched = false
            
            let randomIndex = cardId.count.arc4random
            print(cardId[randomIndex])
            game.cards[i].identifier = (cardId[randomIndex]+1)/2
            cardId.remove(at: randomIndex)
            print(cardId)
            cardbutton[i].setTitle("",for: UIControl.State.normal)
            cardbutton[i].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        
        count = game.calCount(at: 0)
        point = 0
        game.addpoint = 0
        game.matchCards = []
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
                game.cards[index].isTouched = true
            }
            flipAllCount += 1
        case 1:
            for index in cardbutton.indices {
                game.cards[index].isFaceUp = false
                game.cards[index].isMatched = false
                game.cards[index].isTouched = false
            }
            flipAllCount += 1
        default:
            break
        }
        
        updateViewFromModel()
        
        count = game.calCount(at: 0)
        point = 0
        game.addpoint = 0
        game.matchCards = []
    }
    
    func randomEmojiTheme() {
        theme = themeTopic[themeTopic.count.arc4random]
        
      switch theme {
        case "Animals":
            
            emojiChoices = game.emojiChoices.Animals
            break
        case "Faces":
            emojiChoices = game.emojiChoices.Faces
            break
        case "Foods":
            emojiChoices = game.emojiChoices.Foods
            break
        case "Sports":
            emojiChoices = game.emojiChoices.Sports
            break
        case "Countries":
            emojiChoices = game.emojiChoices.Countries
            break
        case "Plants":
            emojiChoices = game.emojiChoices.Plants
            break
            
        default:
            break
        }
        print(emojiChoices)
    }

}
