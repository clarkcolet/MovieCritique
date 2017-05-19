//
//  ViewController_NewsFeed.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 10/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController_NewsFeed: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    

    @IBOutlet weak var FeedTable: UITableView!

    @IBOutlet weak var collectionMovies: UICollectionView!
    @IBOutlet weak var buttonProfile: UIBarButtonItem!
    @IBOutlet weak var buttonSearch: UIBarButtonItem!
    @IBOutlet weak var topSubview: UIView!
    @IBOutlet weak var labelTopSubview: UILabel!
    
   
    
    
    
    var currentRowExternal:TableViewCellMovies!
    
    //CollectionView
    let reuseIdentifier = "cellPosterTop"
    //Table View
    let tableCellIdentifier = "tableActivity"
    
    var currentCellExternal = CollectionViewMovies()
    
    
    var searchBar = UISearchBar()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var items = ["beauty", "startrek", "guardians"]
    var movies = [Movie]()
    var recentReviewFeed = [FeedRecentReview]()


    
    override func viewDidLoad() {
      //  assignbackground()
        super.viewDidLoad()
        
     //  print( UIDevice.current.orientation)
    
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
        
        
        Rest.sharedInstance.getMovies{ (json: JSON) in
            if(json["Status"] == "Success")
            {
                if let results = json["Data"].array {
                    for entry in results {
                        
                        // let user = User(json: entry)
                        
                        self.movies.append(Movie(json: entry))
                        
                    }
                    DispatchQueue.main.async(execute: {
                        
                        self.collectionMovies.reloadData()
                        
                    })
                }
            }
            else
            {
                print("No DATA")
            }
        }
        
        
        
        
        let session = SessionManager()
        
        let param:Dictionary<String,String> = ["UserID" : session.RetriveSession() as String]
        
        Rest.sharedInstance.getFriendsRecentReview(body: param as [String : AnyObject]) { (json: JSON) in
            if(json["Status"] == "Success")
            {
                if let results = json["Data"].array {
                    for entry in results {
                        
                      
                        self.recentReviewFeed.append(FeedRecentReview(json: entry))
                        
                        
                    }
                    DispatchQueue.main.async(execute: {
                        
                       self.FeedTable.reloadData()
                        
                    })
                }
            }
            else
            {
                print("No DATA")
            }
        }

        
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
        print(self.movies.count)
        return self.movies.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cellPosterTop = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewMovies
        
        
        if let url = NSURL(string: movies[indexPath.row].imgSrc){
            if let data = NSData(contentsOf: url as URL){
                cellPosterTop.moviePoster.image = UIImage(data: data as Data)
        }
        }
        cellPosterTop.movieName.text = movies[indexPath.row].title!
        
        //
        
        //
        
        
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
      
            for movie in movies
            {
                if(movie.title == currentCellExternal.movieName.text)
                {
                    
                    vc.externalMovieImage = currentCellExternal.moviePoster.image
                    vc.externalMovieTitle = currentCellExternal.movieName.text!
                    vc.externalMovieDescription = movie.desc!
                    vc.externalMovieActors = movie.cast!
                    vc.externalMovieGenre = movie.genre!
                    vc.externalMovieID = movie.movieID!
                }
            }
            
            
            
//            vc.externalMovieImage = currentCellExternal.moviePoster.image
//            vc.externalMovieDescription = currentCellExternal.
//            vc.externalMovieTitle = "----"
//            vc.externalMovieDescription = "1234"
//            vc.externalMovieActors = "12345678"
//            vc.externalMovieGenre = ""
         
        }
        if segue.identifier == "FromHomeToFriendReview"{
            print("I got inside the segue to get to review")
            let vc = segue.destination as! ViewControllerFriendReview
            vc.externalImageMovie = currentRowExternal.imagePoster.image
            vc.externaltextViewReview = currentRowExternal.textView.text
            vc.externaltextViewDescription = "Description goes here"
            vc.externalLabelTitle = currentRowExternal.labelTitle.text
            vc.title = "Review"
            vc.externalImageFriend = currentRowExternal.imageProfile.image
            
            
            //
            let delimiter = " "
            
            let userActivity = currentRowExternal.labelUserActivity.text
            var username = userActivity?.components(separatedBy: delimiter)

            vc.externalLabelNameFriend = username?[0]
        //
            vc.externalFriendRating = currentRowExternal.rating
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
        return self.recentReviewFeed.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let tableActivity = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! TableViewCellMovies

        if let url = NSURL(string: recentReviewFeed[indexPath.row].imgSrc!){
            if let data = NSData(contentsOf: url as URL){
                tableActivity.imagePoster.image  = UIImage(data: data as Data)
            }
        }
        
        if let url2 = NSURL(string: recentReviewFeed[indexPath.row].userImgSrc!){
            if let data = NSData(contentsOf: url2 as URL){
                tableActivity.imageProfile.image  = UIImage(data: data as Data)
            }
        }
        
        
        tableActivity.labelTitle.text = recentReviewFeed[indexPath.row].title
        tableActivity.labelUserActivity.text = recentReviewFeed[indexPath.row].firstName! +  " made a review "
        tableActivity.textView.text = recentReviewFeed[indexPath.row].review
        
        //
        tableActivity.rating.rating = 3 //HERE GOES RATING
        //
       
        
        
        
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
             //   topSubview.frame.width = view.frame.width
               // topSubview.frame.height = 10
               self.topSubview.frame =  CGRect(x: -1, y: 65, width: self.view.frame.width, height: 36)
                print("X: \(self.labelTopSubview.frame.origin.x)   Y:\(self.labelTopSubview.frame.origin.y) " )
               // self.topSubview.addSubview(self.labelTopSubview)
               // self.labelTopSubview.frame = CGRect(x: 21, y: 65, width: 185, height: 20)
                print("X: \(self.labelTopSubview.frame.origin.x)   Y:\(self.labelTopSubview.frame.origin.y) " )
               
                let cellSize = CGSize(width:self.collectionMovies.frame.width / 10,  height: self.collectionMovies.frame.height/1.2)
                
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
