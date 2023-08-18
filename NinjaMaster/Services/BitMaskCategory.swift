//
//  BitMaskCategory.swift
//  NinjaMaster
//
//  Created by Roman Lantsov on 18.08.2023.
//

import Foundation

struct BitMaskCategory {
    static let none: UInt32 = 0x0 << 0
    static let monster: UInt32 = 0x1 << 0
    static let projectile: UInt32 = 0x1 << 1
    static let all: UInt32 = UInt32.max
}
