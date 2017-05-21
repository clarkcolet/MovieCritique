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
    
    @IBOutlet weak var friendRating: RatingControl!
    
    
    
    var externalImageMovie:UIImage!
    var externalLabelTitle:String!
    var externalLabelActors:String!
    var externalLabelGenre:String!
    var externaltextViewReview:String!
    var externaltextViewDescription:String!
    var externalLabelNameFriend:String!
    var externalImageFriend:UIImage!
    var externalFriendRating:RatingControl!
    
    @IBOutlet weak var bottomSubview: UIView!
    
    @IBOutlet weak var topSubview: UIView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.tintColor = UIColor.black;
        imageMovie.image = externalImageMovie
        labelTitle.text  = externalLabelTitle
        labelGenre.text  = externalLabelGenre
        labelActors.text = externalLabelActors
        textViewReview.text = externaltextViewReview
        textViewDescription.text = externaltextViewDescription
        labelNameFriend.text = externalLabelNameFriend
        buttonFriend.setImage(externalImageFriend, for: .normal) 
        friendRating.rating = externalFriendRating.rating


        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
               
                
            case .landscapeLeft,.landscapeRight :
                
                print("Landscape")
                
                self.bottomSubview.frame =  CGRect(x: 0, y: 674, width: self.view.frame.width, height: 400)
                self.imageMovie.frame = CGRect(x: 0, y: 221, width: 331, height: 453)
                self.topSubview.frame =  CGRect(x: 331, y: 221, width: self.view.frame.width-331, height: 453)
              //  self.topSubview.subviews.removeAll()
              //  self.topSubview.addSubview(labelTitle)
               // self.labelTitle.frame = CGRect(x: 30, y: 30, width: self.topSubview.frame.width, height: 36)
                
                
              //  print("X: \(self.labelTopSubview.frame.origin.x)   Y:\(self.labelTopSubview.frame.origin.y) " )
                // self.topSubview.addSubview(self.labelTopSubview)
                // self.labelTopSubview.frame = CGRect(x: 21, y: 65, width: 185, height: 20)
               // print("X: \(self.labelTopSubview.frame.origin.x)   Y:\(self.labelTopSubview.frame.origin.y) " )
                
                
            default:
                print("Anything But Portrait")

            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)

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
