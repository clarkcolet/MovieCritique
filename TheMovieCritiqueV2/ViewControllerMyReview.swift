//
//  ViewControllerMyReview.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 15/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerMyReview: UIViewController {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var textViewReview: UITextView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelActors: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDescription: UITextView!
    @IBOutlet weak var movieID: UILabel!
    @IBOutlet weak var myRating: RatingControl!
    
    

    var externalImage:UIImage!
    var externalReview:String!
    var externalTitle:String!
    var externalActors:String!
    var externalGenre:String!
    var externalDescription:String!
    var externalMovieID:String!
    var externalRating:RatingControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageMovie.image = externalImage
        textViewReview.text = externalReview
        labelTitle.text = externalTitle
        labelActors.text = externalActors
        labelGenre.text = externalGenre
        labelDescription.text = externalDescription
        movieID.text = externalMovieID
        
        if externalRating != nil {
        myRating.rating = externalRating.rating
        } else {
            myRating.rating = 0
        }
        
      
        
        self.navigationController?.navigationBar.tintColor = UIColor.black;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SaveReview(_ sender: Any) {
        
        let validator = Validator()
        var validReview:Bool = textViewReview.text.characters.count > 20
        
        if(validReview)
        {
            var session = SessionManager()
            let param:Dictionary<String,String> = ["UserID" : session.RetriveSession() as String, "MovieID" :  self.externalActors as String]
            
            Rest.sharedInstance.saveReview(body: param as [String : AnyObject]) { (json: JSON) in
                if(json["Status"] == "Success")
                {
                    if let results = json["Data"].array {
                        for entry in results {
                            
                        }
                        DispatchQueue.main.async(execute: {
                            
                            
                        })
                    }
                }
                else
                {
                    print("No DATA")
                }
            }

        }
        
        let refreshAlert = UIAlertController(title: "Saved", message: "Your review has been submitted", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
//        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("Handle Cancel Logic here")
//        }))
        
        present(refreshAlert, animated: true, completion: nil)
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
