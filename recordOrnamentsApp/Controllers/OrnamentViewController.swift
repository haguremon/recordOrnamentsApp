//
//  OrnamentViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/06.
//

import UIKit
import SideMenu
import FirebaseAuth

class OrnamentViewController: UIViewController, SideMenuViewControllerDelegate {
    
    var authCredentials: AuthCredentials?
    
    @IBOutlet private var collectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let coverView: UIView = {
        let mainBoundSize: CGSize = UIScreen.main.bounds.size
        let mainFrame = CGRect(x: 0, y: 0, width: mainBoundSize.width, height: mainBoundSize.height)
        
        let view = UIView()
        view.frame = mainFrame
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    func didSelectMeunItem(name: SideMenuItem) {
        menu?.dismiss(animated: true, completion:nil)
        //閉じた時に移動する
        
        switch name {
            
        case .useGuide:
            print("useGuide")
            //present(createViewController()!, animated: true, completion: nil)
        case .signOut:
            print("log out")
            do {
                
                try Auth.auth().signOut()
                
                presentToViewController()
                
                
            } catch  {
                print(error,"ログアウトに失敗sました")
            }
            
        case .contact:
            print("aaaaaaaaa")
            view.backgroundColor = .green
        }
    }
    
    
    
    var menu: SideMenuNavigationController?
    let collectionViewLayout = CollectionViewLayout()
    var color: UIColor? = .darkGray
    let imagename = ["square.and.arrow.up","paperplane","paperplane","paperplane","paperplane","arrow.down.to.line","gear","magnifyingglass","clock","square.and.arrow.up","paperplane","arrow.down.to.line","gear","magnifyingglass","clock"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkIfUserIsLoggedIn()
        //guard let authCredential = self.authCredentials else { return }
       // print("\(authCredential.name)")
        print("hello")
        navigationController?.title = "置物"
        configurenavigationController()
        collectionView.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        configureSearchController()
        setupSideMenu()
        setupCollectionView()
        
        
        
    }
    private func setupSideMenu() {
        weak var sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuViewController
        sideMenuViewController?.delegate = self
        sideMenuViewController?.authCredentials = self.authCredentials
        menu = SideMenuNavigationController(rootViewController: sideMenuViewController!)
        menu?.leftSide = true
        menu?.settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    func checkIfUserIsLoggedIn() {
        // configurenavigationController()
        if Auth.auth().currentUser == nil  {
            //ログイン中じゃない場合はLoginControllerに移動する
            
            
            DispatchQueue.main.async {
                self.checkIfUserIsLoggedIn()
            }
            
            
            
        }
    }
    
    
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        //checkIfUserIsLoggedIn()
    //    }
    //
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        DispatchQueue.main.async {
    //            self.checkIfUserIsLoggedIn()
    //        }
    //
    //
    //    }
    
    
    //override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //      //  checkIfUserIsLoggedIn()
    //    }
    
    
    //loginSegue
    private func presentToViewController() {
        
        //RegisterViewControllerに移動する
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: false, completion: nil)
        //        let navController = UINavigationController(rootViewController: loginViewController)
        //        navController.modalPresentationStyle = .fullScreen
        //        navController.navigationBar.isHidden = true
        //        DispatchQueue.main.async {
        //
        //            self.present(navController, animated: false, completion: nil)
        //
        //        }
        
    }
    func configurenavigationController() {
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func configureSearchController(){
        // searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        //searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = false
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
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "header")
        
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
    //viewForSupplementaryをつけることができるヘッダーやフッターなので
    
    fileprivate func extractedFunc(_ indexPath: IndexPath, _ header1: HeaderCollectionReusableView) -> UICollectionReusableView {
        if indexPath.section == 0 {
            
            header1.label.text = ""
            
        } else {
            
            header1.label.text = ""
            
        }
        
        return header1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "header",
                                                                     for: indexPath) as! HeaderCollectionReusableView
        return extractedFunc(indexPath, header)
    }
    
    
    
    
}


//MRAK: -SideMeun

extension OrnamentViewController: SideMenuNavigationControllerDelegate {
    
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
    
    
    
    
    
    
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        navigationController?.view.addSubview(coverView)
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        coverView.removeFromSuperview()
    }
    
    
    
}
//extension OrnamentViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        didCancelSearch()
//        guard let text = searchBar.text, !text.isEmpty else {
//            return
//        }
//
//        query(text)
//    }
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
//                                                            style: .plain,
//                                                            target: self,
//                                                            action: #selector(didCancelSearch))
//    }
//
//    @objc private func didCancelSearch() {
//        searchBar.resignFirstResponder()
//        navigationItem.rightBarButtonItem = nil
//    }
//
//    private func query(_ text: String) {
//        // Perform in search in the back ends
//    }
//}


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
