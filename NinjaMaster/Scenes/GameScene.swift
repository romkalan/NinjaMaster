//
//  GameScene.swift
//  NinjaMaster
//
//  Created by Roman Lantsov on 16.08.2023.
//

import SpriteKit
import GameplayKit

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func sqrt(a: CGFloat) -> CGFloat {
    CGFloat(sqrtf(Float(a)))
}


extension CGPoint {
    func length() -> CGFloat {
        sqrt((x * x) + (y * y))
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}


class GameScene: SKScene {
    
    var player: SKSpriteNode!
    var monster: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        player = PlayerSprite.populate(to: CGPoint(x: size.width * 0.1, y: size.height * 0.5))
        addChild(player)
        
        run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.run(addMonster), SKAction.wait(forDuration: 1.0)]
        )))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        
        let offset = touchLocation - projectile.position
        if offset.x < 0 { return }
        
        addChild(projectile)
                
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let realDest = shootAmount + projectile.position
                
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
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
