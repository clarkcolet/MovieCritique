//
//  ViewController_NewsFeed.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 10/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewController_NewsFeed: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    


    @IBOutlet weak var collectionMovies: UICollectionView!
    @IBOutlet weak var buttonProfile: UIBarButtonItem!
    @IBOutlet weak var buttonSearch: UIBarButtonItem!
    
    var currentRowExternal:TableViewCellMovies!
    
    //CollectionView
    let reuseIdentifier = "cellPosterTop"
    //Table View
    let tableCellIdentifier = "tableActivity"
    
    var currentCellExternal = CollectionViewMovies()
    
    var searchBar = UISearchBar()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var items = ["beauty", "startrek", "guardians"]
    
    
    override func viewDidLoad() {
      //  assignbackground()
        super.viewDidLoad()
        //var buttonSearchInternal = buttonSearch
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let cellSize = CGSize(width:300 , height:400)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        collectionMovies.setCollectionViewLayout(layout, animated: true)
        
        collectionMovies.reloadData()

        
    }
    
    func assignbackground(){
        let background = UIImage(named: "Background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.items.count)
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cellPosterTop = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewMovies
        
        cellPosterTop.moviePoster.image = UIImage(named: items[indexPath.row])
        // cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        print("I got here")
        return cellPosterTop
    }
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        //let indexPath = collectionView.indexPathForSelectedRow() //optional, to get from any UIButton for example
        
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewMovies
        currentCellExternal = currentCell
        
        performSegue(withIdentifier: "FromHomeToMovie", sender: nil)
     
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FromHomeToMovie"{

        let vc = segue.destination as! ViewControllerMovie
      
            vc.externalMovieImage = currentCellExternal.moviePoster.image
            vc.externalMovieDescription = "_____"
            vc.externalMovieTitle = "----"
            vc.externalMovieDescription = "1234"
            vc.externalMovieActors = "12345678"
            vc.externalMovieGenre = ""
         
        }
        if segue.identifier == "FromHomeToFriendReview"{
            print("I got inside the segue to get to review")
            let vc = segue.destination as! ViewControllerFriendReview
            vc.externalImageMovie = currentRowExternal.imagePoster.image
            vc.externaltextViewReview = "My review goes here"
            vc.externaltextViewDescription = "Description goes here"
            vc.externalLabelTitle = "Title goes here"
            vc.title = "Review"
            vc.externalImageFriend = currentRowExternal.imageProfile.image
            vc.externalLabelNameFriend = "Name of friend goes here"
        }
       

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Table views
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print("about to enter")
        return 1
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("I got at the beginning of the feed thig")
        let tableActivity = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! TableViewCellMovies
        //cellTable.tableLabelTime.text = "5 minutes ago"
        tableActivity.imageProfile.image = UIImage(named: "Account")
        tableActivity.imagePoster.image = UIImage(named: "startrek")
        tableActivity.labelTitle.text = "Star Trek"
        tableActivity.labelUserActivity.text = "John C. made a review:"
        tableActivity.textView.text = "Good film. Worth watching"
       // print("I got at the end of the feed thing")
        return tableActivity
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I was selected: #\(indexPath.item)!")
       
        let currentRow = tableView.cellForRow(at: indexPath) as! TableViewCellMovies
        currentRowExternal = currentRow
        
        performSegue(withIdentifier: "FromHomeToFriendReview", sender: nil)
        
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

    
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       print("tryout")
    searchBar.endEditing(true)
    navigationItem.titleView = nil

   }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
               // self.collectionMovies.removeFromSuperview()
                let cellSize = CGSize(width:300 , height:400)
                
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical //.horizontal
                layout.itemSize = cellSize
                layout.sectionInset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
                layout.minimumLineSpacing = 0.5
                layout.minimumInteritemSpacing = 0.5
                self.collectionMovies.setCollectionViewLayout(layout, animated: true)
                
                self.collectionMovies.reloadData()
                
            case .landscapeLeft,.landscapeRight :
                
                print("Landscape")

               
                let cellSize = CGSize(width:self.collectionMovies.frame.width / 8,  height: self.collectionMovies.frame.height/1.5)
                
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical //.horizontal
                layout.itemSize = cellSize
                layout.sectionInset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
                layout.minimumLineSpacing = 0.5
                layout.minimumInteritemSpacing = 0.5
                self.collectionMovies.setCollectionViewLayout(layout, animated: true)
                
                self.collectionMovies.reloadData()
                
            default:
                print("Anything But Portrait")
              //  self.collectionMovies.removeFromSuperview()
                let cellSize = CGSize(width:self.collectionMovies.frame.width / 4,  height: self.collectionMovies.frame.height/2)
                
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical //.horizontal
                layout.itemSize = cellSize
                layout.sectionInset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
                layout.minimumLineSpacing = 0.5
                layout.minimumInteritemSpacing = 0.5
                self.collectionMovies.setCollectionViewLayout(layout, animated: true)
                
                self.collectionMovies.reloadData()
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
        
    }


}
