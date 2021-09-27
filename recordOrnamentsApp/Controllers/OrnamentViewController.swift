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
    }
    private func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewLayout.ornamentCollectionViewLayout()
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        //collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func setupSideMenu() {
        weak var sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuViewController
        menu = SideMenuNavigationController(rootViewController: sideMenuViewController!)
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
    
    
    @IBAction func createSideMenuButton(_ sender: Any) {
        
        present(menu!, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func barItemReturn(segue: UIStoryboardSegue){
        
        
    }
    
}

//MRAK: -CollectionView
extension OrnamentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        //cell.backgroundColor = .darkGray
        //return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! CollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .darkGray
            //cell.setup(image: UIImage(systemName: "plus"))
        case 1... :
            //color = .green
            cell.backgroundColor = .green
            //cell.setup(image: nil)
        default:
            break
        }
        
        performSegue(withIdentifier: "DetailsView", sender: nil)
        
    }
}
//MRAK: -SideMeun

extension OrnamentViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        navigationController?.view.addSubview(coverView)
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        coverView.removeFromSuperview()
    }
    
    
    
}



