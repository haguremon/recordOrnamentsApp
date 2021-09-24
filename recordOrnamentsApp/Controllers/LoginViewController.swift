//
//  ViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/03.
//

import UIKit


class LoginViewController: UIViewController {
    
    
    
    let customButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func descriptionScreenButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ModalSegue", sender: nil)
        
    }
    
    
    @IBAction func loginButton(_ sender: CustomButton) {
        var logintest: Bool
        logintest = true
        if logintest == true {
            sender.pulsate()
            
        } else {
            sender.errorAnimation(duration: 0.01)
        }
        
    }
    @IBAction func presentToRegistrButton(_ sender: CustomButton) {
        
        
    }
    
    
    @IBAction func loginGuestButton(_ sender: Any) {
        //消した時に保存さされないと警告を出す
        presentToOrnamentViewController()
        
        
    }
    
    
    private func presentToOrnamentViewController() {
        
        performSegue(withIdentifier: "OrnamentViewSegue", sender: nil)
        
    }
    
}

