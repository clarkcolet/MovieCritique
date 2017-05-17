//
//  TableViewCellMovieReviews.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 15/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class TableViewCellMovieReviews: UITableViewCell {
    
    @IBOutlet weak var imageProfile: UIImageView!
   // @IBOutlet weak var labelActivity: UILabel!
   // @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var textViewReview: UITextView!
    @IBOutlet weak var labelReviewDate: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    
    @IBOutlet weak var labelUserName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
