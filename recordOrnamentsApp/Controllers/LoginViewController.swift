//
//  ViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/03.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func descriptionScreenButton(_ sender: UIButton) {
    
       performSegue(withIdentifier: "ModalSegue", sender: nil)
    
    }
    
    
    @IBAction func loginButton(_ sender: CustomButton) {
        
        //ログインがちゃんと認識された時にOrnamentViewControllerに遷移する
        //presentToOrnamentViewController()
        //sender.shake()
        sender.pulsate()
    }
    @IBAction func presentToRegistrButton(_ sender: UIButton) {
        sender.errorAnimation()
    
    }
    
    
    @IBAction func loginGuestButton(_ sender: Any) {
        //消した時に保存さされないと警告を出す
        presentToOrnamentViewController()

        
    }
    
    
    private func presentToOrnamentViewController() {
        
        performSegue(withIdentifier: "OrnamentViewSegue", sender: nil)
    
    }

}

