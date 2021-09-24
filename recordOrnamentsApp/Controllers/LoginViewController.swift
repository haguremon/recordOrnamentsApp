//
//  ViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/03.
//

import UIKit

enum testError : Error {
    case testerror
    case testerror1
}

class LoginViewController: UIViewController, CustomButtonDelegate {
    var touchesBegan: Error?
    
    var touchesEnded: Error?
    
        
    
    
    let customButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func descriptionScreenButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ModalSegue", sender: nil)
        
    }
    
    
    @IBAction func loginButton(_ sender1: CustomButton) {
        
        sender1.delegate = self
        self.touchesBegan = testError.testerror
        self.touchesEnded = testError.testerror1
    }
    @IBAction func presentToRegistrButton(_ sender2: CustomButton) {
        sender2.delegate = self
        
        self.touchesBegan = nil
        self.touchesEnded = nil
        
        
    }
    
    
    @IBAction func loginGuestButton(_ sender: Any) {
        //消した時に保存さされないと警告を出す
        presentToOrnamentViewController()
        
        
    }
    
    
    private func presentToOrnamentViewController() {
        
        performSegue(withIdentifier: "OrnamentViewSegue", sender: nil)
        
    }
    
}

