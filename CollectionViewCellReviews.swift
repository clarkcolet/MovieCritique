//
//  CollectionViewCellReviews.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 12/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class CollectionViewCellReviews: UICollectionViewCell {
    
//        var titleLabel:UILabel = {
//            let label = UILabel(frame: CGRect(x:100, y: 30, width: UIScreen.main.bounds.width , height: 40))
//            label.textAlignment = .left
//            label.lineBreakMode = .byWordWrapping
//            label.numberOfLines = 0
//            return label
//        }()
    var textLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        print(frame.size.width)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imageView)
        
        textLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height/1.8 - 15, width: frame.size.width, height: frame.size.height))
       
        textLabel.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel.textAlignment = .center
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        collectionView!.collectionViewLayout = layout
     
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
