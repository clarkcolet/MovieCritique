//
//  ViewControllerFriends.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 11/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerFriends: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var collectionViewFriendList: UICollectionView!
    
    @IBOutlet weak var collectionViewNewFriends: UICollectionView!
    
    var searchBar = UISearchBar()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let reuseIdentifierCellFriend = "cellFriend"
    let reuseIdentifierCellNewFriend = "cellNewFriend"
    
     var items = ["Dayum R.", "Lionel C."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFriendList.delegate = self
        collectionViewNewFriends.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //MARK: Collection code
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //For Friend List
         if collectionView == collectionViewFriendList {
        return 2
         } else {
            //For New Friends Bar
            return 2
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //For Friend List
        if collectionView == collectionViewFriendList {
            let cellFriend = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCellFriend, for: indexPath as IndexPath) as! CollectionViewFriends
            cellFriend.imageCellFriend.image = UIImage(named: "ContactsYellow")
            
            cellFriend.labelCellFriend.text = items[indexPath.row]
            
            return cellFriend
        } else {
            //For new friends bar
            let cellNewFriend = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCellNewFriend, for: indexPath as IndexPath) as! CollectionViewCellNewFriends
            cellNewFriend.imageNewFriend.image = UIImage(named: "ContactsYellow")
            
            cellNewFriend.labelNewFriend.text = items[indexPath.row]
            
            return cellNewFriend
        }

    }

    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //For friends list
        if collectionView == collectionViewFriendList {
            print("You selected cell #\(indexPath.item)!")
            
            let cellFriend = collectionView.cellForItem(at: indexPath) as! CollectionViewFriends
            print(cellFriend.labelCellFriend.text!)
            
            let friend = self.storyboard?.instantiateViewController(withIdentifier: "friend") as! ViewControllerFriendProfile
            
            friend.navigationTitleExternal  = cellFriend.labelCellFriend.text
            friend.externalLabel = cellFriend.labelCellFriend.text
            friend.externalImage = cellFriend.imageCellFriend.image
            //
            cellFriend.externalFriends = self
            cellFriend.externalFriend = friend
            //
            navigationController?.pushViewController(friend, animated: true)
        } else {
            //For new friends bar
            print("You selected cell #\(indexPath.item)!")
            
            let cellNewFriend = collectionView.cellForItem(at: indexPath) as! CollectionViewCellNewFriends
            print(cellNewFriend.labelNewFriend.text!)
            
            let friend = self.storyboard?.instantiateViewController(withIdentifier: "friend") as! ViewControllerFriendProfile
            
            friend.navigationTitleExternal  = cellNewFriend.labelNewFriend.text
            friend.externalLabel = cellNewFriend.labelNewFriend.text
            friend.externalImage = cellNewFriend.imageNewFriend.image
            
        //
           cellNewFriend.externalFriends = self
            cellNewFriend.externalFriend = friend
            //
            navigationController?.pushViewController(friend, animated: true)
        }
        
    }
    
    @IBAction func showSearchBar(_ sender: UIBarButtonItem) {
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self       //
        let frame = CGRect(x: 0, y: 0, width: 500, height: 44)
        let titleView = UIView(frame: frame)
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.frame = frame
        titleView.addSubview(searchController.searchBar)
        navigationItem.titleView = titleView
        
    }
    
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("tryout")
//        searchBar.endEditing(true)
//        navigationItem.titleView = nil
//        
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("searchText \(searchText)")
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("searchText \(String(describing: searchBar.text))")
//      //  filterContentForSearchFriend(searchText: searchBar.text!)
//    }
    
//    func filterContentForSearchFriend(searchText:String) {
//        //var results = [Movie]()
//      //  print(filteredMovie)
//        filteredMovie.removeAll()
//        for publication in movies {
//            print("Search text: \(searchText)")
//            //a.caseInsensitiveCompare(b) == ComparisonResult.orderedSame
//            if let fullTitle = publication.title {
//                if (fullTitle.lowercased()).contains(searchText.lowercased()) {
//                    filteredMovie.append(publication)
//                }
//            }
//            
//        }
//        
//        print("Filtered movie: \(filteredMovie)")
//        self.collectionMovies.reloadData()
//    }
//    
//    @IBAction func showSearchBar(_ sender: UIBarButtonItem) {
//        
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.dimsBackgroundDuringPresentation = false
//        searchController.searchBar.showsCancelButton = true
//        searchController.searchBar.delegate = self       //
//        let frame = CGRect(x: 0, y: 0, width: 500, height: 44)
//        let titleView = UIView(frame: frame)
//        searchController.searchBar.backgroundImage = UIImage()
//        searchController.searchBar.frame = frame
//        titleView.addSubview(searchController.searchBar)
//        navigationItem.titleView = titleView
//        
//    }
//    
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("tryout")
//        searchBar.endEditing(true)
//        navigationItem.titleView = nil
//        
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("searchText \(searchText)")
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("searchText \(String(describing: searchBar.text))")
//        searchFilm(filmTitle: searchBar.text!)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
