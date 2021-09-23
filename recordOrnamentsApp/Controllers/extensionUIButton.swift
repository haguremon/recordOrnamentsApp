//
//  File.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/23.
//

import Foundation
import UIKit


extension UIButton{
    
    func pulsate(){
        // 強調するボタン
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        pulse.duration = 0.05
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
    
    func flash(){
        // 光るボタン
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    func errorAnimation () {
        // 揺れるボタン
        let shake = CASpringAnimation(keyPath: "position")
        shake.duration = 0.03
        shake.repeatCount = 1.5
        shake.autoreverses = true
        shake.damping = 2.0
        shake.stiffness = 120
        let fromPoint = CGPoint(x: center.x - 4 , y: center.y)
        let toPoint = NSValue(cgPoint: fromPoint)
        
        shake.fromValue = fromPoint
        shake.toValue = toPoint
        
        layer.add(shake, forKey: nil)
    }
    func shake2() {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.duration = 0.5
        animation.fromValue = 1.25
        animation.toValue = 1.0
        animation.mass = 1.0
        animation.initialVelocity = 30.0
        animation.damping = 3.0
        animation.stiffness = 120.0
        layer.add(animation, forKey: nil)
    }
}
