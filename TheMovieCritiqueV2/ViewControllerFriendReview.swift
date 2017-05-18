//
//  ViewControllerFriendReview.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 16/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerFriendReview: UIViewController {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelActors: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var textViewReview: UITextView!
    @IBOutlet weak var textViewDescription: UITextView!

    @IBOutlet weak var buttonFriend: UIButton!
    @IBOutlet weak var labelNameFriend: UILabel!
    
    
    var externalImageMovie:UIImage!
    var externalLabelTitle:String!
    var externalLabelActors:String!
    var externalLabelGenre:String!
    var externaltextViewReview:String!
    var externaltextViewDescription:String!
    var externalLabelNameFriend:String!
    var externalImageFriend:UIImage!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageMovie.image = externalImageMovie
        labelTitle.text  = externalLabelTitle
        labelGenre.text  = externalLabelGenre
        labelActors.text = externalLabelActors
        textViewReview.text = externaltextViewReview
        textViewDescription.text = externaltextViewDescription
        labelNameFriend.text = externalLabelNameFriend
        buttonFriend.imageView?.image = externalImageFriend
        
//        buttonFriend.backgroundColor = UIColor.gray
//        buttonFriend.layer.cornerRadius = 5
//        buttonFriend.layer.borderWidth = 2
//        buttonFriend.layer.borderColor = UIColor.black.cgColor
       // buttonFriend.layer.cornerRadius = 0.5 * buttonFriend.bounds.size.width
      //  buttonFriend.layer.borderColor = UIColor.black.cgColor//UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0, alpha:1).cgColor as CGColor
      //  buttonFriend.layer.borderWidth = 4
      //  buttonFriend.clipsToBounds = true

        // Do any additional setup after loading the view.
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
