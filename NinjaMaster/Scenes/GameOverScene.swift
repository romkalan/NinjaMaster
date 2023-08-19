//
//  GameOverScene.swift
//  NinjaMaster
//
//  Created by Roman Lantsov on 19.08.2023.
//

import SpriteKit

class GameOverScene: SKScene {
    init(size: CGSize, won: Bool) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
