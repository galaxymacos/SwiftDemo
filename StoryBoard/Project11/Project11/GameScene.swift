//
//  GameScene.swift
//  Project11
//
//  Created by Xun Ruan on 2021/8/12.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    let ballsArray = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]
    var scoreLabel: SKLabelNode!
    var ballsLeftLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var ballsLeft = 5{
        didSet{
            if ballsLeft <= 0{
                print("game over")
            }
            ballsLeftLabel.text = "Balls: \(ballsLeft)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet{
            if editingMode {
                editLabel.text = "Done"
            }
            else{
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        for x in stride(from: 0, to: 1025, by: 256){
            makeBouncer(at: CGPoint(x: x, y: 0))
        }
        
        var isGood = true
        for x in stride(from: 128, to: 1024, by: 256){
            makeSlot(at: CGPoint(x: x, y: 0), isGood: isGood)
            isGood.toggle()
        }
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        ballsLeftLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsLeftLabel.text = "Balls: \(ballsLeft)"
        ballsLeftLabel.position = CGPoint(x: 512, y: 700)
        addChild(ballsLeftLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        
        let objects = nodes(at: location)
        
        if objects.contains(editLabel){
            editingMode.toggle()
        }
        else{
            if editingMode{
                // create a box
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zPosition = 0
                box.zRotation = CGFloat.random(in: 0...3)   // in rad
                box.position = location
                box.physicsBody = SKPhysicsBody(rectangleOf: size)
                box.physicsBody?.isDynamic = false
                box.name = "obstruction"
                addChild(box)
            }
            else{
                if ballsLeft <= 0{
                    return
                }
                
                ballsLeft -= 1
                let ball = SKSpriteNode(imageNamed: ballsArray.randomElement()!)
                ball.name = "ball"
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask   // I want to know the information of every collision
                ball.physicsBody?.restitution = 0.4
                ball.position = location
                ball.position.y = 768
                addChild(ball)
                
                
            }
        }
    }
    
    func makeBouncer(at position: CGPoint){
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false  // isDynamic = move by collision and gravity
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool){
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        if isGood{
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        }
        else{
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotBase.name = "bad"
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
        }
        slotBase.position = position
        slotGlow.position = position
        
        let spin = SKAction.rotate(byAngle: CGFloat.pi / 2, duration: 10)
        let foreverSpin = SKAction.repeatForever(spin)
        slotGlow.run(foreverSpin)
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        
        addChild(slotBase)
        addChild(slotGlow)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        
        if nodeA.name == "ball"{
            if nodeB.name == "obstruction"{
                nodeB.removeFromParent()
            }
            collisionBetween(ball: nodeA, object: nodeB)
            
        }
        else if nodeB.name == "ball"{
            if nodeA.name == "obstruction"{
                nodeA.removeFromParent()
            }
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
    
    
    func collisionBetween(ball: SKNode, object: SKNode){
        if object.name == "good"{
            destroy(ball: ball)
            
            score += 1
            // Extra ball when hit goal
            ballsLeft += 1
        }
        else if object.name == "bad"{
            destroy(ball: ball)
            score -= 1
        }
    }
    
    func destroy(ball: SKNode){
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles"){
            print("emit fire particles")
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        else{
            print("Can't find fire particles")
        }
        ball.removeFromParent()
    }
}
