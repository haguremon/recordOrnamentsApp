//
//  CollectionViewCell.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/26.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setup(image: UIImage?){
        imageView.image = image
        // UICollectionViewのcontentViewプロパティには罫線と角丸に関する設定を行う
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 10.0
        
        // UICollectionViewのおおもとの部分にはドロップシャドウに関する設定を行う
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 3, height: 7)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        
    }
    //    override func prepareForReuse() {
    //        super.prepareForReuse()
    //        self.setup(image: nil)
    //        self.backgroundColor = nil
    //    }
}
