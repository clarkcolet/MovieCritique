//
//  ViewControllerFriends.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 11/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerFriends: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionViewFriendList: UICollectionView!
    let reuseIdentifierCellFriend = "cellFriend"
    
     var items = ["Dayum R.", "Ragaga"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFriendList.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //MARK: Collection code
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cellFriend = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCellFriend, for: indexPath as IndexPath) as! CollectionViewFriends
            cellFriend.imageCellFriend.image = UIImage(named: "ContactsYellow")
       
            cellFriend.labelCellFriend.text = items[indexPath.row]

            return cellFriend
    }

    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        let cellFriend = collectionView.cellForItem(at: indexPath) as! CollectionViewFriends
        print(cellFriend.labelCellFriend.text!)

        let friend = self.storyboard?.instantiateViewController(withIdentifier: "friend") as! ViewControllerFriendProfile
        
        friend.navigationTitleExternal  = cellFriend.labelCellFriend.text
        friend.externalLabel = cellFriend.labelCellFriend.text
        
        //
        cellFriend.externalFriends = self
        cellFriend.externalFriend = friend
        //
        navigationController?.pushViewController(friend, animated: true)

        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
