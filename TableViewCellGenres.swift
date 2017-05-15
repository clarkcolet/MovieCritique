//
//  TableViewCellGenres.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 14/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class TableViewCellGenres: UITableViewCell {
    
    
    @IBOutlet weak var labelGenre: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
