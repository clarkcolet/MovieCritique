//
//  TableViewCellMovies.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 10/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class TableViewCellMovies: UITableViewCell {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelUserActivity: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var rating: RatingControl!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
