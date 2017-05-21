//
//  SessionManager.swift
//  Kdc
//
//  MANAGING SESSION
//  Created by nishanth on 03/03/2017.
//  Copyright © 2017 nishanth. All rights reserved.
//

import Foundation

class SessionManager
{
    
    init() {
        
    }
    
    // Create a new Session
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
            preferences.set(user.favouriteGenre, forKey: "FavouriteGenre")


            status = true
        }
        else
        {
            status = false
        }
        
        return status
    }
    
    //Destroy Current Session
    func DestroySession()
    {
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "UserID")
        preferences.removeObject(forKey: "Email")
        preferences.removeObject(forKey: "FirstName")
        preferences.removeObject(forKey: "LastName")
        preferences.removeObject(forKey: "MobileNo")
        preferences.removeObject(forKey: "FavouriteGenre")
        
    }
    
    //Retrive the current Session
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
     
    func RetriveUserFirstName() -> String
    {
        let preferences = UserDefaults.standard
        var FirstName:String = ""
        if preferences.string(forKey: "FirstName") != nil
        {
            FirstName = preferences.string(forKey: "FirstName")!
        }
        return FirstName
    }
    
    func RetriveUserLastName() -> String
    {
        let preferences = UserDefaults.standard
        var LastName:String = ""
        if preferences.string(forKey: "LastName") != nil
        {
            LastName = preferences.string(forKey: "LastName")!
        }
        return LastName
    }
    
    func RetriveUserFavouriteGenre() -> String
    {
        let preferences = UserDefaults.standard
        var FavouriteGenre:String = ""
        if preferences.string(forKey: "FavouriteGenre") != nil
        {
            FavouriteGenre = preferences.string(forKey: "FavouriteGenre")!
        }
        return FavouriteGenre
    }
}
