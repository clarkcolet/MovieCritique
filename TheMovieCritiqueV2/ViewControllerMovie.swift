//
//  ViewControllerMovie.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 15/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerMovie: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelActors: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var textMovieID: UILabel!
    
    @IBOutlet weak var subViewInfo: UIView!
    
    
    
    var externalMovieTitle:String = ""
    var externalMovieImage:UIImage!
    var externalMovieActors:String = ""
    var externalMovieGenre:String = ""
    var externalMovieDescription:String = ""
    var externalMovieID:String = ""
    
    var currentRowExternal:TableViewCellMovieReviews!
    
    var reviews = [FeedRecentReview]()
    
    @IBOutlet weak var tableReviewFeed: UITableView!
    
    let tableCellIdentifier = "tableReviews"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black;

        labelTitle.text = externalMovieTitle
        imageMovie.image = externalMovieImage
        labelGenre.text = externalMovieGenre
        labelActors.text = externalMovieActors
        textViewDescription.text = externalMovieDescription
        textMovieID.text = externalMovieID
        
        let param:Dictionary<String,String> = ["MovieID" : textMovieID.text!]
        
        Rest.sharedInstance.getReviewPerMovie(body: param as [String : AnyObject]) { (json: JSON) in
            if(json["Status"] == "Success")
            {
                if let results = json["Data"].array {
                    for entry in results {
                        
                        
                        self.reviews.append(FeedRecentReview(json: entry))
                        
                        
                    }
                    DispatchQueue.main.async(execute: {
                      self.tableReviewFeed.reloadData()
                        
                    })
                }
            }
            else
            {
                print("No DATA")
            }
        }

        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Table views
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("about to enter")
        return reviews.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("I got at....")
        let tableActivity = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! TableViewCellMovieReviews

        tableActivity.labelUserName.text = reviews[indexPath.row].firstName
        tableActivity.labelReviewDate.text = reviews[indexPath.row].createdOn
        tableActivity.textViewReview.text = reviews[indexPath.row].review
        
        //REVIEW
       // tableActivity.friendRating.rating = 3
        //
        
        let starString:String = reviews[indexPath.row].star! 
        
        //
        tableActivity.friendRating.rating = Int(starString)!
        
        if let url2 = NSURL(string: reviews[indexPath.row].userImgSrc!){
            if let data2 = NSData(contentsOf: url2 as URL){
                tableActivity.imageProfile.image = UIImage(data: data2 as Data)
            }
        }
        
        
        return tableActivity
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I was selected: #\(indexPath.item)!")
        
        let currentRow = tableView.cellForRow(at: indexPath) as! TableViewCellMovieReviews
        currentRowExternal = currentRow
        
        performSegue(withIdentifier: "FromMovieToReview", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FromMovieToReview"{
            
            let vc = segue.destination as! ViewControllerFriendReview
            
            vc.externalImageMovie = imageMovie.image
            vc.externaltextViewDescription =  textViewDescription.text
            vc.externalLabelTitle = labelTitle.text!
           // vc.externalMovieDescription = "1234"
            vc.externalLabelActors = labelActors.text!
            vc.externalLabelGenre = labelGenre.text!
            vc.externalImageFriend = currentRowExternal.imageProfile.image
            vc.externalLabelNameFriend = currentRowExternal.labelUserName.text
           //REVIEW
            vc.externalFriendRating = currentRowExternal.friendRating
            vc.externaltextViewReview = currentRowExternal.textViewReview.text
            
         
        }
        if segue.identifier == "FromMovieToMyReview"{
            print("I got inside the segue to get to my review")
            let vc = segue.destination as! ViewControllerMyReview
            vc.externalImage = imageMovie.image
            vc.externalReview = "My review goes here"
            vc.externalDescription = textViewDescription.text
            vc.externalTitle = labelTitle.text
            vc.externalGenre = labelGenre.text
            vc.externalActors = labelActors.text
            vc.externalMovieID = textMovieID.text
            vc.title = "Write Review"
          //  vc.externalImageFriend = currentRowExternal.imageProfile.image
          //  vc.externalLabelNameFriend = "Name of friend goes here"
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
                // self.collectionMovies.removeFromSuperview()
              //  self.imageMovie.frame = CGRect(x: 0, y: 64, width: 349, height: 521)
                
            case .landscapeLeft,.landscapeRight :
                
                print("Landscape")

               
    
            default:
                print("Anything But Portrait")
   
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
