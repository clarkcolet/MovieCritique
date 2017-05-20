//
//  CollectionViewCellNewFriends.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 20/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class CollectionViewCellNewFriends: UICollectionViewCell {
    
    @IBOutlet weak var imageNewFriend: UIImageView!
    @IBOutlet weak var labelNewFriend: UILabel!
    
    var externalFriends = ViewControllerFriends()
    var externalFriend = ViewControllerFriendProfile()
}
