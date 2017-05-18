//
//  ViewController.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 08/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBOutlet weak var TxtUserName: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    let validator = Validator()
    let sessionM = SessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        
        //
        buttonLogin.layer.cornerRadius = 7
        buttonLogin.layer.shadowColor = UIColor.black.cgColor
        buttonLogin.layer.shadowRadius = 4
        //  buttonLogin.layer.shadowOffset = CGSize(width: 0, height: 5)
        // buttonLogin.layer.shadowOpacity = 0.7

        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        let sessionID:String = sessionM.RetriveSession()
        if sessionID != ""
        {
            print("yes session \(sessionID)")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNav")
            self.present(vc!, animated: true, completion: nil)
        }
        else
        {
            print("NO SESSION")
        }
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func assignbackground(){
        let background = UIImage(named: "Background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
                self.assignbackground()
                
            case .landscapeLeft,.landscapeRight :
                
                print("Landscape")
                self.assignbackground()
                
            default:
                
                print("Anything But Portrait")
                self.assignbackground()
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    @IBAction func LoginClick(_ sender: Any) {
        
        let isValidEmail = validator.validateEmail(email: TxtUserName.text!)
        
        var valid : Bool = false
        
        
        if !isValidEmail
        {
            validator.AnimationShakeTextField(textField: TxtUserName)
        }
        
        if((txtPassword.text?.characters.count)! < 6 || txtPassword.text == "" || (txtPassword.text?.isEmpty)!)
        {
            validator.AnimationShakeTextField(textField: txtPassword)
            valid = false
        }
        else
        {
            valid = true
        }
        
        if(isValidEmail && valid)
        {
            let loginDetails:Dictionary<String,String> = ["Email" : self.TxtUserName.text! as String, "Password" : self.txtPassword.text! as String]
            
            Rest.sharedInstance.getLogin(body: loginDetails as [String : AnyObject]) { (json: JSON) in
                if(json["Status"] == "Success")
                {
                    if let results = json["Data"].array {
                        for entry in results {
                            
                            let user = User(json: entry)
                            
                            self.sessionM.StartSession(user: user)
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNav")
                            self.present(vc!, animated: true, completion: nil)
                            
                        }
                        DispatchQueue.main.async(execute: {
                            
                            
                            
                        })
                    }
                }
                else
                {
                    print("No DATA")
                }
            }
            
        }
        
        
        
    }
    

}

