//
//  FeedRecentReview.swift
//  TheMovieCritiqueV2
//
//  Created by nishanth on 16/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedRecentReview
{
    public var reviewID : String?
    public var movieID : String?
    public var userID : String?
    public var review : String?
    public var star : String?
    public var deleted : String?
    public var createdOn : String?
    public var updatedOn : String?
    public var title : String?
    public var subtitle : String?
    public var cast : String?
    public var genre : String?
    public var released : String?
    public var imgSrc : String?
    public var firstName : String?
    public var lastName : String?
    public var dOB : String?
    public var mobileNo : String?
    public var email : String?
    public var password : String?
    public var favouriteGenre : String?
    public var friendID : String?
    public var userImgSrc : String?

    
  
    required public init(json: JSON) {
        
        reviewID = json["ReviewID"].stringValue
        movieID = json["MovieID"].stringValue
        userID = json["UserID"] .stringValue
        review = json["Review"] .stringValue
        star = json["Star"].stringValue
        deleted = json["Deleted"] .stringValue
        createdOn = json["CreatedOn"] .stringValue
        updatedOn = json["UpdatedOn"] .stringValue
        title = json["Title"] .stringValue
        subtitle = json["Subtitle"] .stringValue
        cast = json["Cast"] .stringValue
        genre = json["Genre"].stringValue
        released = json["Released"] .stringValue
        imgSrc = json["ImgSrc"] .stringValue
        firstName = json["FirstName"] .stringValue
        lastName = json["LastName"] .stringValue
        dOB = json["DOB"].stringValue
        mobileNo = json["MobileNo"].stringValue
        email = json["Email"].stringValue
        password = json["Password"] .stringValue
        favouriteGenre = json["FavouriteGenre"] .stringValue
        userImgSrc = json["UserImg"] .stringValue
        friendID = json["FriendID"] .stringValue
    }
    

    
    
    
    
    
    
}
