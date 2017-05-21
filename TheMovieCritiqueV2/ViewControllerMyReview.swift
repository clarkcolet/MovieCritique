//
//  ViewControllerMyReview.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 15/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerMyReview: UIViewController, UITextViewDelegate {
    
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
    
    var success:Bool = true
    

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
        textViewReview.delegate = self
     // textViewReview .addTarget(self, action: "myTargetFunction:", forControlEvents: UIControlEvents.TouchDown)
        
        self.navigationController?.navigationBar.tintColor = UIColor.black;
    }
    
    func textViewDidBeginEditing(_ textViewReview: UITextView) {
        DispatchQueue.main.async {
            textViewReview.selectAll(nil)
            print("Started editing")
        }
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
                    print("Success REVIEW")
                    self.success = true
                }
                else
                {
                    self.success = false
                    print("No DATA REVIEW")
                }
            }

        } else{
            validator.AnimationShakeTextFieldTextView(textField: textViewReview)
        }
        
        if (success) {
        let refreshAlert = UIAlertController(title: "Saved", message: "Your review has been submitted", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        

        
        present(refreshAlert, animated: true, completion: nil)
        } else {
            let refreshAlert = UIAlertController(title: "Saved", message: "Error submitting review", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
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
