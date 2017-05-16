//
//  SessionManager.swift
//  Kdc
//
//  Created by nishanth on 03/03/2017.
//  Copyright © 2017 nishanth. All rights reserved.
//

import Foundation

class SessionManager
{
  //  let rest = RestApiManager()
    
    init() {
        
    }
    
    func StartSession(user:User) -> Bool
    {
        let preferences = UserDefaults.standard
       
        var status : Bool = false
        
        if user.userID != ""
        {
            preferences.set(user.userID, forKey: "UserID")
            preferences.set(user.email, forKey: "Email")
            preferences.set(user.firstName, forKey: "FirstName")
            preferences.set(user.lastName, forKey: "LastName")
            preferences.set(user.mobileNo, forKey: "MobileNo")


            status = true
        }
        else
        {
            status = false
        }
        
        return status
    }
    
    
    func DestroySession()
    {
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "UserID")
        preferences.removeObject(forKey: "Email")
        preferences.removeObject(forKey: "FirstName")
        preferences.removeObject(forKey: "LastName")
        preferences.removeObject(forKey: "MobileNo")
        
    }
    
    
    func RetriveSession() -> String
    {
        let preferences = UserDefaults.standard
        var SessionID:String = ""
        if preferences.string(forKey: "UserID") != nil
        {
         SessionID = preferences.string(forKey: "UserID")!
        }
        return SessionID
    }
     
    
    
}
