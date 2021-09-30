//
//  OrnamentViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/06.
//

import UIKit
import SideMenu

class OrnamentViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    
    private let coverView: UIView = {
        let mainBoundSize: CGSize = UIScreen.main.bounds.size
        let mainFrame = CGRect(x: 0, y: 0, width: mainBoundSize.width, height: mainBoundSize.height)
        
        let view = UIView()
        view.frame = mainFrame
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    var menu: SideMenuNavigationController? = nil
    let collectionViewLayout = CollectionViewLayout()
    var color: UIColor? = .darkGray
    let imagename = ["square.and.arrow.up","paperplane","paperplane","paperplane","paperplane","arrow.down.to.line","gear","magnifyingglass","clock","square.and.arrow.up","paperplane","arrow.down.to.line","gear","magnifyingglass","clock"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        setupCollectionView()
//
//        NotificationCenter.default.addObserver(self, selector: #selector(showkeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(hidekeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    @IBAction func createSideMenuButton(_ sender: Any) {
        
        present(menu!, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func barItemReturn(segue: UIStoryboardSegue){
        
        
    }
    
}





//MRAK: -CollectionView
extension OrnamentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewLayout.ornamentCollectionViewLayout()
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagename.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        
        switch indexPath.row {
        case 0:
            cell.layer.cornerRadius = 75
            cell.backgroundColor = .darkGray
            cell.layer.shadowRadius = 1
            cell.layer.shadowOpacity = 1
            cell.bounds.size.height = 150
            cell.bounds.size.width = 150
            cell.setup(image: UIImage(systemName: "plus"))
            return cell
        default:
            cell.layer.cornerRadius = 20
            cell.backgroundColor = .darkGray
            cell.setup(image: UIImage(systemName: imagename[indexPath.row - 1]))
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! CollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .darkGray
            
        case 1... :
            
            cell.backgroundColor = .green
            
        default:
            break
        }
        
        performSegue(withIdentifier: "DetailsView", sender: nil)
        
    }
}


//MRAK: -SideMeun

extension OrnamentViewController: SideMenuNavigationControllerDelegate, SideMenuViewControllerDelegate {
    
    private func createViewController() -> SideMenuViewController? {
        weak var sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuViewController
        return sideMenuViewController
    }
    private func setupSideMenu() {
        createViewController()!.delegate = self
        
        menu = SideMenuNavigationController(rootViewController: createViewController()!)
        menu?.leftSide = true
        menu?.settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
    
    private func makeSettings() -> SideMenuSettings {
        var settings = SideMenuSettings()
        //動作を指定
        settings.presentationStyle = .menuSlideIn
        //メニューの陰影度
        settings.presentationStyle.onTopShadowOpacity = 1.0
        //ステータスバーの透明度
        settings.statusBarEndAlpha = 0
        return settings
    }
    
    
    
    
    
    func didSelectMeunItem(name: SideMenuItem) {
        menu?.dismiss(animated: true, completion:nil)
        //閉じた時に移動する
        
        switch name {
            
        case .useGuide:
            present(createViewController()!, animated: true, completion: nil)
        case .signOut:
            view.backgroundColor = .blue
        case .contact:
            view.backgroundColor = .green
        }
    }
    
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        navigationController?.view.addSubview(coverView)
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        coverView.removeFromSuperview()
    }
    
    
    
}



////MRAK: -keyboard
//extension OrnamentViewController {
//    @objc func showkeyboard(notification: Notification){
//        //キーボードのフレームを求める
//        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
//        //https://qiita.com/st43/items/3802624d15a8dded8169 //フレームについて
//        guard let kayboardMinY = keyboardFrame?.minY else { return } //キーボードの高さ
//        let registerButtonMaxY = view.frame.maxY //registerButtonの底辺の位置
//        let distance = registerButtonMaxY - kayboardMinY + 30
//        let transform = CGAffineTransform(translationX: 0, y: -distance)
//        //https://qiita.com/hachinobu/items/57d4c305c907805b4a53 //Animation
//        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
//            self.view.transform = transform
//        })
//        //print("kayboardMinY: \(String(describing: kayboardMinY)), registerButtonMaxY: \(registerButtonMaxY)")
//    }
//    @objc func hidekeyboard(){
//        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
//            self.view.transform = .identity
//        })
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//}
//
//
