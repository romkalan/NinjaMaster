//
//  MonsterSprite.swift
//  NinjaMaster
//
//  Created by Roman Lantsov on 17.08.2023.
//

import SpriteKit

class MonsterSprite: SKSpriteNode {
    static func populate() -> MonsterSprite {
        let monster = MonsterSprite(imageNamed: "monster")
        monster.zPosition = 100
        return monster
    }
    
}
