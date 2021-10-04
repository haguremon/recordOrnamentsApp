//
//  ViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/03.
// 

import UIKit
import Lottie

class LoginViewController: UIViewController {
    
    
    
    let customButton = CustomButton()
    
    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    animation()
    }

    
    @IBAction func descriptionScreenButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ModalSegue", sender: nil)
        
    }
    private func animation() {
        

        let background = AnimationView(name: "background2")
        background.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + 10)
        background.center = self.view.center
        background.loopMode = .autoReverse
        background.contentMode = .scaleAspectFit
        background.animationSpeed = 0.7

        animationView.addSubview(background)

        background.play()
        
        
    }
    
    
    func testanimation(logintest: Bool, button: UIButton){
        if logintest == true {
            button.pulsate()
            
        } else {
            button.errorAnimation(duration: 0.01)
        }
        
    }
    @IBAction func loginButton(_ sender: CustomButton) {
        testanimation(logintest: true, button: sender)
        
    }

    @IBAction func presentToRegistrButton(_ sender: CustomButton) {
        testanimation(logintest: false, button: sender)
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
    
}

