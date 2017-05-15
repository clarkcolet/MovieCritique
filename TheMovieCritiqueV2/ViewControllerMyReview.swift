//
//  ViewControllerMyReview.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 15/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerMyReview: UIViewController {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var textViewReview: UITextView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelActors: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDescription: UITextView!

    var externalImage:UIImage!
    var externalReview:String!
    var externalTitle:String!
    var externalActors:String!
    var externalGenre:String!
    var externalDescription:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageMovie.image = externalImage
        textViewReview.text = externalReview
        labelTitle.text = externalTitle
        labelActors.text = externalActors
        labelGenre.text = externalGenre
        labelDescription.text = externalDescription
        
        self.navigationController?.navigationBar.tintColor = UIColor.black;
       // self.navigationController.
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
