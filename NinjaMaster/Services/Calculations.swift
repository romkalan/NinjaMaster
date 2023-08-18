//
//  Calculations.swift
//  NinjaMaster
//
//  Created by Roman Lantsov on 18.08.2023.
//

import Foundation

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
