//
//  DescriptionViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/08.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var uiView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    let collectionViewLayout = CollectionViewLayout()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        scrollViewsetup()
        setupCollectionView()
    }
    func scrollViewsetup(){
      
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewLayout.descriptionCollectionViewLayout(height: uiView.frame.height)
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        //collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @IBAction func logincSreenButton(_ sender: UIButton) {
   
    dismiss(animated: true, completion: nil)
        
    }
 
}
extension DescriptionViewController: UIScrollViewDelegate{


}

extension DescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
//        cell.frame.size.width = uiView.frame.size.width - 20
     //cell.frame.size.height = uiView.frame.size.height 
        
        cell.backgroundColor = .green
        return cell
   
    }
    
    
    
    
}
