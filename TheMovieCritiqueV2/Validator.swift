//
//  Validator.swift
//  Kdc
//
//  Created by nishanth on 27/01/2017.
//  Copyright © 2017 nishanth. All rights reserved.
//

import Foundation
import UIKit


class Validator
{
    public init(){}
    
    func validator()
    {
    
    }
    
    func validateEmail(email:String) -> Bool
    {
        var valid:Bool = true
        
        let EmailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            if(email == "" || email.isEmpty)
            {
                valid = false;
            }
            else
            {
                let regex = try NSRegularExpression(pattern: EmailRegEx)
                let nsString = email as NSString
                let results = regex.matches(in: email,range: NSRange(location: 0, length: nsString.length))
                
                
                if(results.count == 0)
                {
                    valid = false;
                }
                
            }
        } catch let _ as NSError {
            print("invalid regis")
            valid = false
        }
        
        return valid
    }
    
    func validateOnlyText(value:String) -> Bool {
        var valid:Bool = true;
        let RegexFormat = "[A-Za-z]"

        do{
        if(value.isEmpty || value == "")
        {
            valid = false
        }
        else
        {
            let regex = try NSRegularExpression(pattern: RegexFormat)
            let nsString = value as NSString
            let results = regex.matches(in: value,range: NSRange(location: 0, length: nsString.length))
            
            
            if(results.count == 0)
            {
                valid = false;
            }

        }
        }
        catch let _ as NSError
        {
            print("invalid regis")
            valid = false
        }
        
        return valid
    }

    func AnimationShakeTextField(textField:UITextField){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint.init(x: textField.center.x - 5, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint.init(x:textField.center.x + 5, y:textField.center.y))
        
        textField.backgroundColor = UIColor.red
        
        textField.layer.add(animation, forKey: "position")
        
       // textField.layer.borderColor = UIColor.red.cgColor
       // textField.layer.borderWidth = 1
    }
    
    func validatePhoneNumb(phoneNumb:String) -> Bool
    {
        var valid:Bool = true
        
        let regEx = "[0-9]"
        
        do {
            if(phoneNumb == "" || phoneNumb.isEmpty || phoneNumb.characters.count < 6)
            {
                valid = false;
            }
            else
            {
                let regex = try NSRegularExpression(pattern: regEx)
                let nsString = phoneNumb as NSString
                let results = regex.matches(in: phoneNumb,range: NSRange(location: 0, length: nsString.length))
                
                
                if(results.count == 0)
                {
                    valid = false;
                }
                
            }
        } catch let _ as NSError {
            print("invalid regis")
            valid = false
        }
        
        return valid
    }
    
   
    
    
    
}
