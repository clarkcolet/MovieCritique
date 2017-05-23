//
//  ViewControllerMovieList.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 14/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerMovieList: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,  UISearchBarDelegate{
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    @IBOutlet weak var buttonGenres: UIBarButtonItem!
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    var refreshControl: UIRefreshControl!
    
    
    let reuseIdentifier = "cellMovie"
    var itemsImage = ["beauty", "startrek", "guardians"]
    var itemsTitle = ["Beauty and the Beast", "Startrek", "Guardians of the Galaxy"]
    
    var movies = [Movie]()
    var filteredMovie = [Movie]()
    
    var currentCellExternal = CollectionViewCellMovieList()
    
    var searchBar = UISearchBar()
    let searchController = UISearchController(searchResultsController: nil)

    let movieTitle:String = ""
    let movieDesc:String = ""
    let movieCast:String = ""
    let releaseYear:String = ""
    var movieGenre:String = ""
    
    var session = SessionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "All Genres"
       // self.navigationController?.title = "All Genres"
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
        
        reloadData()

        // Do any additional setup after loading the view.
    }
    
    func reloadData()
    {
        
        let param:Dictionary<String,String> = ["UserID" : session.RetriveSession() as String]
        
        Rest.sharedInstance.getMovies(body: param as [String : AnyObject]){ (json: JSON) in
            if(json["Status"] == "Success")
            {
                if let results = json["Data"].array {
                    for entry in results {
                        
                        // let user = User(json: entry)
                        self.movies.append(Movie(json: entry))
                        self.filteredMovie.append(Movie(json:entry))
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
        
        self.refreshControl = UIRefreshControl()
        //self.view.addSubview(self.refreshControl)
        refreshControl.addTarget(self, action:#selector(doSomething), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    
    func doSomething() {
        print("START")
        movies.removeAll()
        filteredMovie.removeAll()

        let param:Dictionary<String,String> = ["UserID" : session.RetriveSession() as String]
        
        Rest.sharedInstance.getMovies(body: param as [String : AnyObject]){ (json: JSON) in
            if(json["Status"] == "Success")
            {
                if let results = json["Data"].array {
                    for entry in results {
                        
                        // let user = User(json: entry)
                        self.movies.append(Movie(json: entry))
                        self.filteredMovie.append(Movie(json:entry))
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
        
        
    
        refreshControl.endRefreshing()
        
       
        print("FINISH")
        
    }

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.filteredMovie.count)
        return self.filteredMovie.count
    }
    
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cellMovie = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCellMovieList
        
        
        if let url = NSURL(string: filteredMovie[indexPath.row].imgSrc){
            if let data = NSData(contentsOf: url as URL){
              //  cellPosterTop.moviePoster.image = UIImage(data: data as Data)
                cellMovie.imageMovie.image = UIImage(data: data as Data)

            }
        }
        
        movieGenre = filteredMovie[indexPath.row].genre
        
        
        cellMovie.labelMovie.text = filteredMovie[indexPath.row].title
        
        cellMovie.labelMovie.numberOfLines = 1
        cellMovie.labelMovie.lineBreakMode = NSLineBreakMode.byWordWrapping
        
       // cellMovie.backgroundView?.layer.cornerRadius = 8
       // cellMovie.backgroundView?.layer.masksToBounds = true

      //  cellMovie.backgroundColor = UIColor.lightGray
        
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        
        return cellMovie
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showList(_ sender: UIBarButtonItem) {
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "list") as! ViewControllerGenreList
        
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
      
        let popoverMenuViewController = vc.popoverPresentationController
        popoverMenuViewController!.permittedArrowDirections = .up
        popoverMenuViewController!.delegate = self as? UIPopoverPresentationControllerDelegate
        popoverMenuViewController!.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(x:0, y: 0,width: 100,height: 50)
        vc.preferredContentSize = CGSize(width: 200, height: 420)
        vc.externalMovieList = self
        self.present(vc, animated: true, completion: nil)
    }
    
  

    
//    func setFilteredData(genre:String)
//    {
//        self.filteredMovie.removeAll()
//          self.filteredMovie = movies.filter { movie in
//             movie.genre.contains(genre)
//        }
//        print(filteredMovie)
//        self.collectionMovies.reloadData()
//        
//    }
    
        
        
        func filterContentForSearchText(searchText:String) {
            //var results = [Movie]()
            print(filteredMovie)
            filteredMovie.removeAll()
            if(searchText != "All")
            {
                for publication in movies {
                    if let fullTitle = publication.genre {
                        if (fullTitle).contains(searchText) {
                                filteredMovie.append(publication)
                            }
                    }
                }
            }
            else
            {
                filteredMovie.append(contentsOf: movies)
            }
        

        print("Filtered movie: \(filteredMovie)")
        self.collectionMovies.reloadData()

    }
    
    func filterContentForSearchTextAll(searchText:String) {
        //var results = [Movie]()
        print(filteredMovie)
        filteredMovie.removeAll()
            for publication in movies {
              
                //a.caseInsensitiveCompare(b) == ComparisonResult.orderedSame
                if let fullTitle = publication.title {
                    if (fullTitle.lowercased()).contains(searchText.lowercased()) {
                        filteredMovie.append(publication)
                    }
                }
        
        }
        
        
        print("Filtered movie: \(filteredMovie)")
        self.collectionMovies.reloadData()
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        print("You selected cell #\(indexPath.item)!")
        
        
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCellMovieList
        currentCellExternal = currentCell
        
        performSegue(withIdentifier: "FromMoviesToMovie", sender: nil)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromMoviesToMovie"{
            
            let vc = segue.destination as! ViewControllerMovie
            for movie in filteredMovie
            {
                if(movie.title == currentCellExternal.labelMovie.text)
                {
                  
            vc.externalMovieImage = currentCellExternal.imageMovie.image
            vc.externalMovieTitle = currentCellExternal.labelMovie.text!
            vc.externalMovieDescription = movie.desc!
            vc.externalMovieActors = movie.cast!
            vc.externalMovieGenre = movie.genre!
            vc.externalMovieID = movie.movieID!
                    
                    if movie.favourite == "0" || movie.favourite == ""
                    {
                        vc.externalHeartFilled = false
                    }
                    else
                    {
                        vc.externalHeartFilled = true
                        vc.externalFavouriteID = movie.favourite
                    }
                }
            }
            
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
        ///////////
        filterContentForSearchTextAll(searchText: searchBar.text!)
        //////
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
