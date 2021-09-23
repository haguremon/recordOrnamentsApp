//
//  NewRegistrationsViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/04.
//

import UIKit

class NewRegistrationsViewController: UIViewController {

   
    
    @IBOutlet weak var iconLabel: UILabel!
    
    @IBOutlet weak var iconImgeView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iconImgeView.layer.cornerRadius = 58

    }
    
    @IBAction func tapSelectIcon(_ sender: UITapGestureRecognizer){
        
        performSegue(withIdentifier: "PushSegue", sender: nil)
    
    }

}
