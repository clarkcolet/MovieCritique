//
//  TableViewCellReviews.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 13/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class TableViewCellReviews: UITableViewCell {


    
    let imageMovie = UIImageView()
    let nameUser = UILabel()
    let movieTitle = UILabel()
    let time = UILabel()
    let review = UILabel()
    let rating = RatingControl()
  // let review = UITextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        imageMovie.translatesAutoresizingMaskIntoConstraints = false
        nameUser.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        review.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false

       review.numberOfLines = 5
       review.lineBreakMode = NSLineBreakMode.byWordWrapping
        
       nameUser.font = UIFont.boldSystemFont(ofSize: 20)
       movieTitle.font = UIFont.boldSystemFont(ofSize: 20)
       time.font = UIFont.boldSystemFont(ofSize: 18)
       review.font = UIFont.systemFont(ofSize: 18)
       rating.distribution = .fillEqually
       rating.isUserInteractionEnabled = false
       
        
        
        contentView.addSubview(imageMovie)
        contentView.addSubview(nameUser)
        contentView.addSubview(movieTitle)
        contentView.addSubview(time)
        contentView.addSubview(review)
        contentView.addSubview(rating)
        
        let viewsDict = [
            "image" : imageMovie,
            "username" : nameUser,
            "message" : movieTitle,
            "labTime" : time,
            "review"  : review,
            "rating"  : rating
            ] as [String : Any]
        
       // contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image(300)]", options: [], metrics: nil, views: viewsDict))
        
         contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image(300)]-[rating(30)]", options: [], metrics: nil, views: viewsDict))
        
     //   contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(300)]-[rating]", options: [], metrics: nil, views: viewsDict))

        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(200)]-[username]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(200)]-[message]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(200)]-[review]-|", options: [], metrics: nil, views: viewsDict))
        

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[labTime]-(<=0)-[message]", options: [], metrics: nil, views: viewsDict))

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-(<=0)-[message]", options: [], metrics: nil, views: viewsDict))
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[review(200)]", options: [], metrics: nil, views: viewsDict))
        
        //contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image]-(<=0)-[rating]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[rating]-(<=0)-[message]", options: [], metrics: nil, views: viewsDict))
        ///////
        // contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image(300)]-[rating]", options: [], metrics: nil, views: viewsDict))
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  //  override func setSelected(_ selected: Bool, animated: Bool) {
    //    super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
  //  }

}
