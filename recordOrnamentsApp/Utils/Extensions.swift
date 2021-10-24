//
//  Extensions.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/10/23.
//

import JGProgressHUD
import UIKit

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    //インジゲーターの処理
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
    
    
    
}


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    static var offWhiteOrBlack: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                let rgbValue: CGFloat = traitCollection.userInterfaceStyle == .dark ? 0 : 247
                return UIColor(r: rgbValue, g: rgbValue, b: rgbValue)
            }
        } else {
            return UIColor(r: 247, g: 247, b: 247)
        }
    }
    
    static var offBlackOrWhite: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                let rgbValue: CGFloat = traitCollection.userInterfaceStyle == .dark ? 247 : 0
                return UIColor(r: rgbValue, g: rgbValue, b: rgbValue)
            }
        } else {
            return UIColor(r: 0, g: 0, b: 0)
        }
    }
}

extension UIButton {
    
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
    
    func flash() {
        // 光るボタン
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    func errorAnimation (duration: CFTimeInterval) {
        // 揺れるボタン
        let shake = CASpringAnimation(keyPath: "position")
        shake.duration = duration
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.damping = 2.0
        shake.stiffness = 120
        let fromPoint = CGPoint(x: center.x - 4 , y: center.y)
        let toPoint = NSValue(cgPoint: fromPoint)
        
        shake.fromValue = fromPoint
        shake.toValue = toPoint
        //        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {() -> Void in
        //            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
        //            self.alpha = 1
        //        },completion: nil)
        
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
    
    
    func showAnimation(_ show: Bool) {
        if show {
            pulsate()
            
        } else {
            errorAnimation(duration: 0.01)
            
        }
    }
    
    
}
