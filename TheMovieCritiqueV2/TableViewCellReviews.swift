//
//  TableViewCellReviews.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 13/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class TableViewCellReviews: UITableViewCell {


    
    let imageUser = UIImageView()
    let nameUser = UILabel()
    let reviewTitle = UILabel()
    let time = UILabel()
    let review = UILabel()
  // let review = UITextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        imageUser.translatesAutoresizingMaskIntoConstraints = false
        nameUser.translatesAutoresizingMaskIntoConstraints = false
        reviewTitle.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        review.translatesAutoresizingMaskIntoConstraints = false

       review.numberOfLines = 5
       review.lineBreakMode = NSLineBreakMode.byWordWrapping
        
       nameUser.font = UIFont.boldSystemFont(ofSize: 20)
       reviewTitle.font = UIFont.boldSystemFont(ofSize: 20)
       time.font = UIFont.boldSystemFont(ofSize: 18)
       review.font = UIFont.systemFont(ofSize: 18)
        
        contentView.addSubview(imageUser)
        contentView.addSubview(nameUser)
        contentView.addSubview(reviewTitle)
        contentView.addSubview(time)
        contentView.addSubview(review)
        
        let viewsDict = [
            "image" : imageUser,
            "username" : nameUser,
            "message" : reviewTitle,
            "labTime" : time,
            "review"  : review,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image(300)]", options: [], metrics: nil, views: viewsDict))

        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(200)]-[username]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(200)]-[message]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(200)]-[review]-|", options: [], metrics: nil, views: viewsDict))
        

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[labTime]-(<=0)-[message]", options: [], metrics: nil, views: viewsDict))

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-(<=0)-[message]", options: [], metrics: nil, views: viewsDict))
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[review(200)]", options: [], metrics: nil, views: viewsDict))
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  //  override func setSelected(_ selected: Bool, animated: Bool) {
    //    super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
  //  }

}
