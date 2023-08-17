//
//  PlayerSprite.swift
//  NinjaMaster
//
//  Created by Roman Lantsov on 17.08.2023.
//

import SpriteKit

class PlayerSprite: SKSpriteNode {
    static func populate(to point: CGPoint) -> PlayerSprite {
        let player = PlayerSprite(imageNamed: "player")
        player.zPosition = 100
        player.position = point
        return player
    }
}
