//
//  Rest.swift
//  TheMovieCritiqueV2
//
//  Created by nishanth on 16/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import Foundation
import SwiftyJSON
typealias ServiceResponse = (JSON, NSError?) -> Void

class Rest:NSObject
{
    
    let BaseURL = "http://alphacentauri.uk/public/index.php/" //define the url globally

    static let sharedInstance = Rest()
    
    func getLogin(body:[String:AnyObject],onCompletion: @escaping (JSON) -> Void) {
        makeHTTPPostRequest(path: "login",body: body, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func signup(body:[String:AnyObject],onCompletion: @escaping (JSON) -> Void) {
        makeHTTPPostRequest(path: "signup",body: body, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func saveReview(body:[String:AnyObject],onCompletion: @escaping (JSON) -> Void) {
        makeHTTPPostRequest(path: "saveReview",body: body, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    func getMovies(onCompletion: @escaping (JSON) -> Void) {
        makeHTTPGetRequest(path: "getMovies", onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }

    func getFriendsRecentReview(body:[String:AnyObject],onCompletion: @escaping (JSON) -> Void) {
        makeHTTPPostRequest(path: "getFriendsRecentReview",body: body, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    
    func getReviewPerMovie(body:[String:AnyObject],onCompletion: @escaping (JSON) -> Void) {
        makeHTTPPostRequest(path: "getReviewPerMovie",body: body, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    public func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: BaseURL + path)! as URL)
        
        // Set the method to POST
        request.httpMethod = "POST"
        
        do {
            // Set the POST body for the request
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
            
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error as! NSError)
                }
            })
            task.resume()
        } catch {
            // Create your personal error
            onCompletion(nil, nil)
        }
    }
    
    private func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: BaseURL + path)! as URL)
        
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, nil)
            } else {
                onCompletion(nil, error as! NSError)
            }
        })
        task.resume()
    }
    
    
}
