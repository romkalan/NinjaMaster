//
//  GameScene.swift
//  NinjaMaster
//
//  Created by Roman Lantsov on 16.08.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    var monster: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        player = PlayerSprite.populate(to: CGPoint(x: size.width * 0.1, y: size.height * 0.5))
        addChild(player)
        
        run(
            SKAction.repeatForever(
                SKAction.sequence(
                    [SKAction.run(addMonster), SKAction.wait(forDuration: 1.0)]
                )
            )
        )
    }
    
    func spawnMonsters() {
        run(SKAction.repeatForever(SKAction.sequence([])))
    }
    
    func addMonster() {
        monster = MonsterSprite.populate()
        let actualY = CGFloat(arc4random()).truncatingRemainder(dividingBy: size.height - monster.size.height * 2)
        monster.position = CGPoint(
            x: size.width + monster.size.width / 2,
            y: actualY
        )
        
        addChild(monster)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let moveMonster = SKAction.move(
            to: CGPoint(x: -monster.size.width/2, y: actualY),
            duration: TimeInterval(actualDuration)
        )
        let removeMonster = SKAction.removeFromParent()

        let sequence = SKAction.sequence([moveMonster, removeMonster])
        monster.run(sequence)
        
    }
    
    func random() -> CGFloat {
        CGFloat(arc4random() / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        random() * (max - min) + min
    }
}
