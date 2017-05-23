//
//  ViewControllerFriendProfile.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 12/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerFriendProfile: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var buttonReviews: UIButton!
    @IBOutlet weak var buttonFavourites: UIButton!
    
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelMovie: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelUnderline: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var labelFriendName: UILabel!
    var collectionView: UICollectionView!
    var tableView: UITableView!

    var navigationTitleExternal:String!
    var externalLabel:String!
    var reviews:Bool = false
    var tableViewFirstTime:Bool = true
    var externalImage:UIImage!
    var externalGenre:String = ""
    
     var boolRight:Bool = true
    
    var currentCellExternal = CollectionViewCellReviews()
    var currentRowExternal = TableViewCellReviews()
    
    var boolRow:Bool = false
    
    var tasks: [UserImage] = []
    
    var reviewsList: [FeedRecentReview] = []
    
    var favourites: [Movie] = []
    
    var session = SessionManager()
    
    var validator = Validator()
    
    var externalProfilePhoto:UIImage!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    @IBOutlet weak var innerLabel: UILabel!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.title = navigationTitleExternal
        innerLabel.text = externalLabel
        self.imageUser.image = externalImage
        self.labelGenre.text = externalGenre
        
         self.navigationController?.navigationBar.tintColor = UIColor.black;
        
       buttonFavourites.setTitleColor(UIColor.black, for: UIControlState.normal)
       labelUnderline.textColor = UIColor.black
        
       buttonReviews.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       // layout.minimumInteritemSpacing = 10
        //layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 200, height: 320)
        
        
      //  print(subView.frame.width)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCellReviews.self, forCellWithReuseIdentifier: "Cell")
        
        subView.addSubview(collectionView)
        
        
        getData()
        
        let param:Dictionary<String,String> = ["UserID" : session.RetriveSession() as String]
        
        labelName.text = session.RetriveUserFirstName()
        labelGenre.text = session.RetriveUserFavouriteGenre()
        
        Rest.sharedInstance.getFriendsRecentReview(body: param as [String : AnyObject]) { (json: JSON) in
            if(json["Status"] == "Success")
            {
                if let results = json["Data"].array {
                    for entry in results {
                        
                        
                        self.reviewsList.append(FeedRecentReview(json: entry))
                        
                        
                    }
                    DispatchQueue.main.async(execute: {
                        
                        self.collectionView.reloadData()
                        
                    })
                }
            }
            else
            {
                print("No DATA")
            }
        }
        
        let param2:Dictionary<String,String> = ["UserID" : session.RetriveSession() as String]
        
        Rest.sharedInstance.getFavourites(body: param2 as [String : AnyObject]) { (json: JSON) in
            if(json["Status"] == "Success")
            {
                if let results = json["Data"].array {
                    for entry in results {
                        
                        
                        self.favourites.append(Movie(json: entry))
                        
                        
                    }
                    DispatchQueue.main.async(execute: {
                        
                        self.collectionView.reloadData()
                        
                    })
                }
            }
            else
            {
                print("No DATA")
            }
        }
        
        
    }
    
    
    
    func getData() {
        print("Attempt to try to enter tasks count \(tasks.count)")
        
        do {
            tasks = try context.fetch(UserImage.fetchRequest())
            
            print(tasks.count)
        } catch {
            print("Fetching Failed")
        }
        
        if(tasks.count > 0) {
            let task = tasks[0]
            
          //  buttonProfile.setImage(UIImage(data: task.imageData! as Data), for: .normal)
            
            
            
            print("I'm here inside tasks count")
        }
        
    }
    
    func loadCollectionView(){
       
        collectionView.removeFromSuperview()
        if(!tableViewFirstTime) {
        tableView.removeFromSuperview()
        }
        
       
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 200, height: 320)
        
      //  print(subView.frame.width)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCellReviews.self, forCellWithReuseIdentifier: "Cell")
        
        subView.addSubview(collectionView)
        
        subView.reloadInputViews()
      
  
    }
     // MARK: - TableView
    func loadTableView() {

        collectionView.removeFromSuperview()
        
        if(!tableViewFirstTime) {
            tableView.removeFromSuperview()
        }
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 350
      
        tableView.register(TableViewCellReviews.self, forCellReuseIdentifier: "ReviewCell")

        subView.addSubview(tableView)
        tableViewFirstTime = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I was selected: #\(indexPath.item)!")
        boolRow = true
        let currentRow = tableView.cellForRow(at: indexPath) as! TableViewCellReviews
        currentRowExternal = currentRow
        
        performSegue(withIdentifier: "FromFriendProfileToReview", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath as IndexPath) as! TableViewCellReviews
        
        if let url = NSURL(string: reviewsList[indexPath.row].imgSrc!){
            if let data = NSData(contentsOf: url as URL){
                cell.imageMovie.image  = UIImage(data: data as Data)
                // cell.imageMovie.image = UIImage(named: "beauty")
                
                
            }
        }
        
        
        
       // cell.movieTitle.text = reviewsList[indexPath.row].title
        cell.time.text = reviewsList[indexPath.row].createdOn
        cell.nameUser.text = reviewsList[indexPath.row].title
        cell.review.text = reviewsList[indexPath.row].review
        
        let starString:String = reviewsList[indexPath.row].star!
        cell.rating.rating = Int(starString)!


        return cell
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
                if(!self.reviews)
                {
                self.loadCollectionView()
                } else
                {
                    self.loadTableView()
                }
                
            case .landscapeLeft,.landscapeRight :
                
                print("Landscape")
                if(!self.reviews) {
                    self.loadCollectionView()
                } else {
                    self.loadTableView()
                }
                
            default:
                
                print("Anything But Portrait")
                self.loadCollectionView()
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCellReviews
        
       
        cell.textLabel.text = favourites[indexPath.row].title
        
        if let url = NSURL(string: favourites[indexPath.row].imgSrc!){
            if let data = NSData(contentsOf: url as URL){
                cell.imageView.image  = UIImage(data: data as Data)
                // cell.imageMovie.image = UIImage(named: "beauty")
                
                
            }
        }
        
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
        boolRow = false
        
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCellReviews
        currentCellExternal = currentCell
        
        performSegue(withIdentifier: "FromFriendProfileToMovie", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromFriendProfileToReview"{
            
            let vc = segue.destination as! ViewControllerFriendReview

                vc.externalImageMovie = currentRowExternal.imageMovie.image
                vc.externaltextViewReview = currentRowExternal.review.text
                vc.externalLabelTitle = currentRowExternal.movieTitle.text
                vc.externaltextViewDescription = "Description of the film goes here"
                vc.externalLabelGenre = "Genre goes here"
                vc.externalLabelActors = "Actors go here"
                vc.externalFriendRating = currentRowExternal.rating
                vc.externalImageFriend = imageUser.image
                vc.externalLabelNameFriend = labelFriendName.text

                vc.title = "Review"
   
        }
        if segue.identifier == "FromFriendProfileToMovie"{
            
            let vc = segue.destination as! ViewControllerMovie
            
            vc.externalMovieTitle = currentCellExternal.textLabel.text!
            vc.externalMovieImage = currentCellExternal.imageView.image
            vc.externalMovieDescription = "Description of the film goes here"
            vc.externalMovieGenre = "Genre goes here"
            vc.externalMovieActors = "Actors go here"
            //vc.externalRating = currentRowExternal.rating
            vc.title = currentCellExternal.textLabel.text
            
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showReviews(_ sender: UIButton) {
        print("reviews pressed")
        reviews = true
        buttonReviews.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        buttonFavourites.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        
        loadTableView()
        if(boolRight){
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.labelUnderline.frame.origin.x -= 512
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        boolRight = false
    }
    
    @IBAction func showFavourites(_ sender: UIButton) {

        print("favourites pressed")
        
        reviews = false
        buttonFavourites.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        buttonReviews.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        
        if(!boolRight) {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.labelUnderline.frame.origin.x += 512
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        boolRight = true
        loadCollectionView()
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        print ("Right")
        if(!boolRight){
            showFavourites(buttonFavourites)
        }
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
       print("Left")
        if(boolRight){
            showReviews(buttonReviews)
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

}
