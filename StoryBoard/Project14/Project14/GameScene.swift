//
//  GameScene.swift
//  Project14
//
//  Created by Xun Ruan on 2021/8/18.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var gameScore:SKLabelNode!
    
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
   
}
