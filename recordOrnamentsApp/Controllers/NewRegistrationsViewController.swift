//
//  NewRegistrationsViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/04.
//

import UIKit
import Lottie

class NewRegistrationsViewController: UIViewController {
    @IBOutlet private var animationView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    private var selectedImage: UIImage? = UIImage(named: "plus_photo")
   
    @IBOutlet private var emailTextField: UITextField!
   
    @IBOutlet private var passwordTextField: UITextField!
    
    @IBOutlet private var userNameTextField: UITextField!
    
    @IBOutlet private var registerButton: UIButton!
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        print("tap")
        handleAuthToFirebase()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        movingBackground()
        configureUI()
        congigureButtton()
    }
    
    @IBAction func setProfileImage(_ sender: UITapGestureRecognizer){
        print("UITapGestureRecognizer")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    
    }
    private func handleAuthToFirebase() {
        guard let email = emailTextField.text, !email.isEmpty ,
              let password = passwordTextField.text, password.count > 7 ,
              let name = userNameTextField.text, !name.isEmpty else { return }
        let authCredential = AuthCredentials(email: email, password: password, name: name, profileImage: selectedImage!)
        print("handleAuthToFirebase: \(authCredential)")
        AuthService.registerUser(withCredential: authCredential) { (error) in
            if let error = error {
                print("DEBUG: Failed to register user\(error.localizedDescription)")
                print("error")
                return
            }

           // self.dismiss(animated: true, completion: nil)
            let ornamentViewController = self.storyboard?.instantiateViewController(identifier: "OrnamentViewController") as! OrnamentViewController
            ornamentViewController.authCredentials = authCredential
            self.navigationController?.pushViewController(ornamentViewController, animated: true)

       // self.present(ornamentViewController, animated: true, completion: nil)
        }
//        ornamentViewController.modalPresentationStyle = .fullScreen
//        let naornamentViewController = UINavigationController(rootViewController: ornamentViewController)
//        self.navigationController.pop
//        self.navigationController?.pushViewController(naornamentViewController, animated: true)
        print("成功")
        
    }
    private func transitionToOrnamentView() {
        
        
    }
    
    private func configureUI() {
        profileImageView.image = UIImage(named: "plus_photo")
        profileImageView.layer.cornerRadius = 20
    }
    private func  congigureButtton() {
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.keyboardType = .emailAddress
        userNameTextField.keyboardType = .namePhonePad
        
        registerButton.isEnabled = false
        
        registerButton.layer.shadowColor = UIColor.gray.cgColor
        registerButton.layer.cornerRadius = 10
        registerButton.layer.shadowRadius = 5
        registerButton.layer.shadowOpacity = 1.0
        //registerButton.layer.cornerRadius = 10 //角を丸く
        registerButton.backgroundColor = UIColor(r: 180, g: 255, b: 211)
       //registerButton.backgroundColor = UIColor.rgb(red: 180, green: 255, blue: 221)
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    private func movingBackground() {
        
        
        let background = AnimationView(name: "background2")
        background.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + 10)
        background.center = view.center
        background.loopMode = .autoReverse
        background.contentMode = .scaleAspectFit
        background.animationSpeed = 0.7
        
        animationView.addSubview(background)
        background.play()
        
        
    }

}

//  MARK: -UIImagePickerControllerDelegate
extension NewRegistrationsViewController :UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        self.selectedImage = selectedImage
        
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.borderColor = UIColor.white.cgColor
            profileImageView.layer.borderWidth = 2
//            profileImageView.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        profileImageView.image = selectedImage
        
            self.dismiss(animated: true, completion: nil)
    }

    
}
extension NewRegistrationsViewController :UITextFieldDelegate { //可読性の向上ｗ
   
    func textFieldDidChangeSelection(_ textField: UITextField) {
       let emailIsEmpty = emailTextField.text?.isEmpty ?? true
       let passwordIsEmpty = passwordTextField.text?.isEmpty ?? true
       let usernameIsEmpty = userNameTextField.text?.isEmpty ?? true
       if emailIsEmpty || passwordIsEmpty || usernameIsEmpty {
           registerButton.isEnabled = false
           registerButton.backgroundColor = UIColor(r: 180, g: 255, b: 221)
       } else {
           registerButton.isEnabled = true
          registerButton.backgroundColor = UIColor(r: 0, g: 255, b: 150)
       }
   }


}
