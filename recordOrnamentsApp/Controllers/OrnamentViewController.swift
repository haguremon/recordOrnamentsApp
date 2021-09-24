//
//  OrnamentViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/06.
//

import UIKit
import SideMenu

class OrnamentViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var menu: SideMenuNavigationController? = nil
    let collectionViewLayout = CollectionViewLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        setupCollectionView()
    }
    private func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewLayout.OrnamentCollectionViewLayout()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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

extension OrnamentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .darkGray
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .green
    }
    

    
}


