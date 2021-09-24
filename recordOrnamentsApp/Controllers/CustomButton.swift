//
//  File2.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/23.
//

import Foundation
import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}


// MARK: - Private functions
extension CustomButton {

    //影付きのボタンの生成
    internal func commonInit(){
        self.layer.shadowOffset = CGSize(width: 1, height: 1 )
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 20
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1.0
    }

    //ボタンが押された時のアニメーション//0.1 // 0.0
    internal func touchStartAnimation(duration: TimeInterval,delay: TimeInterval) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95);
            self.alpha = 0.9
        },completion: nil)
    }

    //ボタンから手が離れた時のアニメーション
    func touchEndAnimation(duration: TimeInterval,delay: TimeInterval) {
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.alpha = 1
        },completion: nil)

    }
}
