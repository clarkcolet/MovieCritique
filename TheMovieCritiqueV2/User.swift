

import Foundation
import SwiftyJSON

public class User {
	public var userID : String!
	public var firstName : String!
	public var lastName : String!
	public var dOB : String!
	public var mobileNo : String!
	public var email : String!
	public var password : String!
	public var favouriteGenre : String!
	public var createdOn : String!
	public var updatedOn : String!

    required public init(json: JSON) {
    
        userID = json["UserID"].stringValue
        firstName = json["FirstName"].stringValue
        lastName = json["LastName"].stringValue
        dOB = json["DOB"].stringValue
        mobileNo = json["MobileNo"].stringValue
        email = json["Email"].stringValue
        password = json["Password"].stringValue
        favouriteGenre = json["FavouriteGenre"].stringValue
        createdOn = json["CreatedOn"].stringValue
        updatedOn = json["UpdatedOn"].stringValue
    }

}