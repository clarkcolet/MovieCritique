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
    
    
    
    var externalMovieTitle:String = ""
    var externalMovieImage:UIImage!
    var externalMovieActors:String = ""
    var externalMovieGenre:String = ""
    var externalMovieDescription:String = ""
    var externalMovieID:String = ""
    
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
        
        let param:Dictionary<String,String> = ["MovieID" : textMovieID.text! as String]
        
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

        if let url = NSURL(string: reviews[indexPath.row].imgSrc!){
            if let data = NSData(contentsOf: url as URL){
                tableActivity.imagePoster.image = UIImage(data: data as Data)
            }
        }
        
        if let url = NSURL(string: reviews[indexPath.row].userImgSrc!){
            if let data = NSData(contentsOf: url as URL){
                tableActivity.imageProfile.image = UIImage(data: data as Data)
            }
        }
        
        
        
        
        
        return tableActivity
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
