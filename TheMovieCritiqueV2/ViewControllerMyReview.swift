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
    let session = SessionManager()

    

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
       // myRating.rating = externalRating.rating
        
        self.navigationController?.navigationBar.tintColor = UIColor.black;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SaveReview(_ sender: Any) {
        
        let validator = Validator()
        var validReview:Bool = textViewReview.text.characters.count > 5
        
        var validRating:Bool = myRating.rating > 0
        
        print(myRating.rating)
        print("\(validRating)  Hello \(validReview) and \(self.movieID.text)")
        if(validReview && validRating)
        {
            let param:Dictionary<String,Any> = ["UserID" : session.RetriveSession() as String, "MovieID" :  self.movieID.text as! String, "Rating" :  myRating.rating, "Review" : self.textViewReview.text as String]
            
            Rest.sharedInstance.saveReview(body: param as [String : AnyObject]) { (json: JSON) in
                if(json["Status"] == "Success")
                {
                    print("Success")
                }
                else
                {
                    print("No DATA")
                }
            }

        } else{
            validator.AnimationShakeTextFieldTextView(textField: textViewReview)
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
