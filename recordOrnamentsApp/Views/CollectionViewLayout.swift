//
//  CollectionViewLayout.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/24.
//

import Foundation
import UIKit

class  CollectionViewLayout {
    
     func  OrnamentCollectionViewLayout() -> UICollectionViewLayout {
        
         let layout = UICollectionViewCompositionalLayout { [ weak self ] (index ,env) in
            self?.ornamentCategories()
        }
        
        
        return layout
    }
    private func ornamentCategories() -> NSCollectionLayoutSection {
        
            let item = NSCollectionLayoutItem(layoutSize: .init(
                                                widthDimension: .fractionalWidth(0.5),
                                                heightDimension: .absolute(150)))
            
        item.contentInsets = .init(top: 2, leading: 8, bottom: 12, trailing: 8)
            
            
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                                                    widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(1000)),                     subitems: [item])
        
            group.contentInsets = .init(top: 3, leading: 10, bottom: 0, trailing: 10)


            let section = NSCollectionLayoutSection(group: group)
            
            return section
        
        }
    
    
    
}
