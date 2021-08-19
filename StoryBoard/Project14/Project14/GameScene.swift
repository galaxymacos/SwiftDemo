//
//  GameScene.swift
//  Project14
//
//  Created by Xun Ruan on 2021/8/18.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var slots = [WhackSlot]()
    var gameScore:SKLabelNode!
    
    var numRounds = 0
    
    var popupTime = 0.991
    
    var score = 0{
        didSet{
            gameScore.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        for i in 0..<5 {
            createSlot(at: CGPoint(x: 100 + (i*170), y: 410))
        }
        for i in 0..<4 {
            createSlot(at: CGPoint(x: 180 + (i*170), y: 320))
        }
        for i in 0..<5 {
            createSlot(at: CGPoint(x: 100 + (i*170), y: 230))
        }
        for i in 0..<4 {
            createSlot(at: CGPoint(x: 180 + (i*170), y: 140))
        }
        
        createEnemy()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        
        let touchLocation = touch.location(in: self)
        
        let tappedNodes = nodes(at: touchLocation)
        for tappedNode in tappedNodes {
            // Because we are tapping the sprite node
            guard let whackSlot = tappedNode.parent?.parent as? WhackSlot else {return}
            if whackSlot.isHit {continue}
            if !whackSlot.isVisible {continue}
            if tappedNode.name == "charFriend"{
                score += 1
                whackSlot.hit()
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
            }
            else{
                score -= 5
                whackSlot.hit()
                whackSlot.charNode.xScale = 0.85
                whackSlot.charNode.yScale = 0.85
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }
        }
        
    }
    
    func createSlot(at position: CGPoint){
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    
    func createEnemy(){
        numRounds += 1
        if numRounds >= 2{
            for slot in slots {
                slot.hide()
                run(SKAction.playSoundFileNamed("gameOver.m4a", waitForCompletion: false))
            }
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            label.text = "Score: \(score)"
            label.position = CGPoint(x: 10, y: 500)
            label.horizontalAlignmentMode = .left
            addChild(label)
            
            return
        }
        
        popupTime *= 0.991
        slots.shuffle()
        
        if Int.random(in: 0...12) > 4{
            slots[1].show(hideTime: popupTime)
        }
        if Int.random(in: 0...12) > 8{
            slots[2].show(hideTime: popupTime)
        }
        if Int.random(in: 0...12) > 10{
            slots[3].show(hideTime: popupTime)
        }
        if Int.random(in: 0...12) > 11{
            slots[4].show(hideTime: popupTime)
        }
        let minDelay = popupTime / 2
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay){[weak self] in
            self?.createEnemy()
        }
    }
   
}
