//
//  ViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/03.
// 

import UIKit
import Lottie

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet private var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movingBackground()
      
    }
        
    @IBAction func descriptionScreenButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ModalSegue", sender: nil)
        
    }
    private func movingBackground() {
        
        let background = AnimationView(name: "background2")
        background.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + 10)
        background.center = self.view.center
        background.loopMode = .autoReverse
        background.contentMode = .scaleAspectFit
        background.animationSpeed = 0.7

        animationView.addSubview(background)

        background.play()
        
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        sender.showAnimation(false)
    }
    
    
    
    @IBAction func loginGuestButton(_ sender: Any) {
        //消した時に保存さされないと警告を出す
        presentToOrnamentViewController()
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    private func presentToOrnamentViewController() {
        
        performSegue(withIdentifier: "OrnamentViewSegue", sender: nil)
        
    }
    @IBAction private func exit(segue: UIStoryboardSegue) {
        
    }
    
}

