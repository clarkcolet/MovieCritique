//
//  Movies.swift
//  TheMovieCritiqueV2
//
//  Created by nishanth on 16/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie
{
    
    public var movieID : String!
    public var title : String!
    public var subtitle : String!
    public var cast : String!
    public var genre : String!
    public var released : String!
    public var imgSrc : String!
    public var deleted : String!
    public var createdOn : String!
    public var updatedOn : String!
    
    required public init(json: JSON) {
        movieID = json["MovieID"].stringValue
        title = json["Title"].stringValue
        subtitle = json["Subtitle"].stringValue
        cast = json["Cast"].stringValue
        genre = json["Genre"].stringValue
        released = json["Released"].stringValue
        imgSrc = json["ImgSrc"].stringValue
        deleted = json["Deleted"].stringValue
        createdOn = json["CreatedOn"].stringValue
        updatedOn = json["UpdatedOn"].stringValue
    }


    
}
