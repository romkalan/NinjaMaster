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
    var projectile: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.white
        
        player = PlayerSprite.populate(to: CGPoint(x: size.width * 0.1, y: size.height * 0.5))
        addChild(player)
        
        run(SKAction.repeatForever(SKAction.sequence(
            [SKAction.run(addMonster), SKAction.wait(forDuration: 0.5)]
        )))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        
        let offset = touchLocation - projectile.position
        if offset.x < 0 { return }
        
        addChild(projectile)
        addPhysicsToProjectile()
        
        // Находим направление через единичный вектор
        let direction = offset.normalized()
        // увеличиваем конечную точку назначения чтобы наш обхъект вышел за пределы экрана
        let shootAmount = direction * 1000
        // переопределяем конечную точку чтобы она начинала отсчет от точки появления
        let realDest = shootAmount + projectile.position
                
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func addPhysicsToProjectile() {
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width / 2)
        projectile.physicsBody?.isDynamic = false
        projectile.physicsBody?.categoryBitMask = BitMaskCategory.projectile
        projectile.physicsBody?.contactTestBitMask = BitMaskCategory.monster
        projectile.physicsBody?.collisionBitMask = 0
        projectile.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func addMonster() {
        monster = MonsterSprite.populate()
        let actualY = CGFloat(arc4random()).truncatingRemainder(dividingBy: size.height - monster.size.height * 2)
        monster.position = CGPoint(
            x: size.width + monster.size.width / 2,
            y: actualY
        )
        
        addChild(monster)
        addPhysicsToMonster()
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let moveMonster = SKAction.move(
            to: CGPoint(x: -monster.size.width/2, y: actualY),
            duration: TimeInterval(actualDuration)
        )
        let removeMonster = SKAction.removeFromParent()

        let sequence = SKAction.sequence([moveMonster, removeMonster])
        monster.run(sequence)
        
    }
    
    func addPhysicsToMonster() {
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
        monster.physicsBody?.isDynamic = true
        monster.physicsBody?.categoryBitMask = BitMaskCategory.monster
        monster.physicsBody?.contactTestBitMask = BitMaskCategory.projectile
        monster.physicsBody?.collisionBitMask = 0
    }
    
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode) {
        projectile.removeFromParent()
        monster.removeFromParent()
    }
    
    func random() -> CGFloat {
        CGFloat(arc4random() / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        random() * (max - min) + min
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & BitMaskCategory.monster != 0) && (secondBody.categoryBitMask & BitMaskCategory.projectile != 0)) {
            guard let monster = firstBody.node as? SKSpriteNode else { return }
            guard let projectile = secondBody.node as? SKSpriteNode else { return }
            
            projectileDidCollideWithMonster(projectile: projectile, monster: monster)
        }
    }
}
