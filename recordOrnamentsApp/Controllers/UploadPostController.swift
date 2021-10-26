//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by IwasakI Yuta on 2021-10-13.
//

import UIKit

//ここで委任する
protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}
//画面を選択したらここに移動して　メモ等をfirebaseに保存する
class UploadPostController: UIViewController {
//
//    // MARK: - Properties
    weak var delegate: UploadPostControllerDelegate?
    var currentUser: User?
//
//
    var selectedImage: UIImage? {
        didSet{ photoImageView.image = selectedImage }
    }
//
//
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("写真を追加する", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        return button
    }()

    
    @objc func addPhoto() {
        
        print("tapaaa")
        
    }
    private lazy var nameTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "名前を付ける"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textColor = .label
        tv.delegate = self
        tv.placeholderShouldCenter = false
        return tv
    }()
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "メモをする"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textColor = .label
        tv.delegate = self
        tv.placeholderShouldCenter = false
        return tv
    }()

    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/500"
        return label
    }()

//    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

       // view.backgroundColor = .orange
        
    }
//
//    // MARK: - Actions
    @objc func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func seni(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        //ログイン後に飛びたいストーリボード。Identifier は Main.storyboard で設定。
        let ornamentViewController = storyboard.instantiateViewController(identifier: "OrnamentViewController") as! OrnamentViewController
        //ornamentViewController.modalPresentationStyle = .fullScreen
        
        //navigationController?.pushViewController(ornamentViewController, animated: true)
        let navVC = UINavigationController(rootViewController: ornamentViewController)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
//        navVC.modalPresentationStyle = .fullScreen
        
    }
//
    @objc func didTapDone() {
   
        guard let image = selectedImage else { return }
        guard let caption = captionTextView.text else { return }
        guard let user = currentUser else { return }
        //ここでインジケーターが発動する
        showLoader(true)
//
        PostService.uploadPost(caption: caption, image: image, user: user) { (error) in
            //uploadできたらインジケーターが終わる
            self.showLoader(false)
            if let error = error {
                print("DEBUG: Failed to upload post \(error.localizedDescription)")
                return
            }
            //ポストが成功した時の処理 tabバーもホームに移動したいのでプロトコルを使って委任する
            self.dismiss(animated: true, completion: nil)
//            self.tabBarController?.selectedIndex = 0
            print("didTapDone()")//delegateに値が入ってるのでcontrollerDidFinishUploadingPost()を使うことができる
            //rightBarButtonItemが押された時にcontrollerDidFinishUploadingPostが発動する
           // self.seni()
        }
    }
//
//    // MARK: - Helpers
    func checkMaxLength(_ textView: UITextView){
       //のカウントを超える場合は
        if (textView.text.count) > 500 {
            //UITextViewに入力できないくなる
            textView.deleteBackward()
        }
    }
//
    func configureUI(){
       
        view.backgroundColor = .systemBackground
        nameTextView.layer.borderWidth = 1
        nameTextView.layer.borderColor = UIColor.secondaryLabel.cgColor
        captionTextView.layer.borderWidth = 1
        captionTextView.layer.borderColor = UIColor.secondaryLabel.cgColor
        navigationItem.title = "保管"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(didTapDone))
        view.addSubview(nameTextView)
        nameTextView.setDimensions(height: view.bounds.height / 11, width: view.bounds.width)
        nameTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 15)
        nameTextView.centerX(inView: view)
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: view.bounds.height / 3, width: view.bounds.width)
        photoImageView.anchor(top: nameTextView.bottomAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10

        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5, height: 100)

        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: view.rightAnchor,paddingBottom: 0, paddingRight: 14)
        view.addSubview(addPhotoButton)
        //addPhotoButton.setDimensions(height: 55, width: 100)
        addPhotoButton.anchor(top: captionTextView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 100, paddingRight: 100, height: 55)
    }
}


// MARK: - UITextFieldDelegate
//textViewの文字のカウントを認知することができる
extension UploadPostController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/300"
    }
}
