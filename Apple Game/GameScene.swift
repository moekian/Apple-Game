//
//  GameScene.swift
//  Apple Game
//
//  Created by Mohammad Kiani on 2023-01-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var basket: SKSpriteNode!
    
    private var apples = Array<SKSpriteNode>()
    private var nextAppleTime: TimeInterval!
    
    var score: Int = 0
    var scoreLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        let backgroundTexture = SKTexture(image: #imageLiteral(resourceName: "Background"))
        let node = SKSpriteNode(texture: backgroundTexture)
        node.size = CGSize(width: 750, height: 1334)
        self.addChild(node)
        
        let basketTexture = SKTexture(image: #imageLiteral(resourceName: "Basket"))
        basket = SKSpriteNode(texture: basketTexture)
        basket.size = CGSize(width: 140, height: 130)
        basket.position = CGPoint(x: 0, y: -540)
        self.addChild(basket)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel?.fontName = "SanFranciso-Bold"
        scoreLabel?.fontSize = 60
        scoreLabel!.position = CGPoint(x: 0, y: 500)
        self.addChild(scoreLabel!)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        basket.position = CGPoint(x: pos.x, y: -540)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        basket?.position = CGPoint(x: pos.x, y: -540)
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    func addApple()
    {
        let appleX = Int.random(in: -300...300)
//        Int(arc4random_uniform(600)) - 300 // Between (-300 and 300)

        let appleTexture = SKTexture(image: #imageLiteral(resourceName: "Apple"))
        let apple = SKSpriteNode(texture: appleTexture)
        apple.size = CGSize(width: 140, height: 130)
        apple.position = CGPoint(x: appleX, y: 540)
        
        let fallAction = SKAction.moveTo(y: -700, duration: 4)
        apple.run(fallAction)

        self.addChild(apple)
        self.apples.append(apple)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if nextAppleTime == nil {
            nextAppleTime = currentTime
        }
        
        if nextAppleTime! <= currentTime {
            self.addApple()
            nextAppleTime = currentTime + 3
        }
        for apple in apples {
            if apple.position.y < -510 && apple.position.y > -550 {
                if abs(apple.position.x - basket!.position.x) < 40 {
                    // Apple Intersects basket
                    score = score + 1
                    scoreLabel?.text = "Score: \(score)"
                    
                    apple.removeFromParent()
                    
                    if let index = apples.firstIndex(of: apple) {
                        apples.remove(at: index)
                    }
                }
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
 
}
