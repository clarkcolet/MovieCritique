//
//  ViewControllerCreateAccount.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 08/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerCreateAccount: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pickerGenre: UIPickerView!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var EmailTxt: UITextField!
    
    @IBOutlet weak var PasswordTxt: UITextField!
    
    @IBOutlet weak var ConfirmPasswordTxt: UITextField!
    
    @IBOutlet weak var FirstNameTxt: UITextField!
    
    @IBOutlet weak var LastNameTxt: UITextField!
    
    @IBOutlet weak var FavouriteMovie: UITextField!
    
    var pickerData: [String] = [String]()
    
    let validator = Validator()
    let sessionM = SessionManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
             // assignbackground()
        navigationBar.topItem?.title = "Create Account"
        buttonSubmit.layer.cornerRadius = 7
        buttonSubmit.layer.shadowColor = UIColor.black.cgColor
        buttonSubmit.layer.shadowRadius = 4

        // Input data into the Array:
        pickerData = ["Action", "Comedy", "Documentary", "Drama", "Family",  "Horror", "Thriller","Sci-Fi"]
        
        
       // let center = NotificationCenter.default
        
     //   center.addObserver(self, selector: #selector(self.keyboardWillShowWithNotification(notification:)), name: .UIKeyboardWillShow, object: view.window)
        self.pickerGenre.dataSource = self;
        self.pickerGenre.delegate = self;
        
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    @IBAction func CreateAccountBtn(_ sender: Any) {
        
        let emailValid = validator.validateEmail(email: EmailTxt.text!)
        if !emailValid {
            validator.AnimationShakeTextField(textField: EmailTxt)
        }
        
        var passwordValid:Bool = false;
        if((PasswordTxt.text?.characters.count)! < 6 || PasswordTxt.text == "" || (PasswordTxt.text?.isEmpty)!)
        {
            validator.AnimationShakeTextField(textField: PasswordTxt)
            passwordValid = false
        }
        else
        {
            passwordValid = true
        }
        
        var confirmPasswordValid:Bool = false
        if((ConfirmPasswordTxt.text?.characters.count)! < 6 || ConfirmPasswordTxt.text == "" || (ConfirmPasswordTxt.text?.isEmpty)!)
        {
            validator.AnimationShakeTextField(textField: ConfirmPasswordTxt)
            confirmPasswordValid = false
        }
        else if ConfirmPasswordTxt.text == PasswordTxt.text
        {
            validator.AnimationShakeTextField(textField: ConfirmPasswordTxt)
            confirmPasswordValid = false
        }
        else
        {
            confirmPasswordValid = true
        }
        
        var firstNameValid:Bool = false
        if((FirstNameTxt.text?.characters.count)! < 3)
        {
            validator.AnimationShakeTextField(textField: FirstNameTxt)
            firstNameValid = false
        } else { firstNameValid = true }
        
        var lastNameValid:Bool = false
        if((LastNameTxt.text?.characters.count)! < 3)
        {
            validator.AnimationShakeTextField(textField: LastNameTxt)
            lastNameValid = false
        } else { lastNameValid = true }
        
        var validFavouriteMovie:Bool = false;
        if((FavouriteMovie.text?.characters.count)! < 3)
        {
            validator.AnimationShakeTextField(textField: FavouriteMovie)
            validFavouriteMovie = false
        } else { validFavouriteMovie = true }

        if(emailValid && passwordValid && firstNameValid
            && lastNameValid && validFavouriteMovie && confirmPasswordValid)
        {
            
        }
        
    }
    
    func startCreating(email:String,password:String,firstname:String,lastname:String,favouritegenre:String,favouritemovie:String,mobileno:String)
    {
        let param:Dictionary<String,String> = ["Email" : self.EmailTxt.text! as String, "Password" : self.PasswordTxt.text! as String,
            "FirstName" : self.FirstNameTxt.text! as String,
            "LastName" : self.LastNameTxt.text! as String,
            "MobileNo" : "" as String, //not implemented
            "FavouriteGenre" : "" as String,
            "FavouriteMovie" : self.FavouriteMovie.text! as String,
            "ImgSrc" : "" as String,//not implemented
            "DOB" : "" as String // not implemented]
                                               
                                               ]
        
        Rest.sharedInstance.signup(body: param as [String : AnyObject]) { (json: JSON) in
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
    
    
//    func assignbackground(){
//        let background = UIImage(named: "Background")
//
//        var imageView : UIImageView!
//        imageView = UIImageView(frame: view.bounds)
//        imageView.contentMode =  UIViewContentMode.scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.image = background
//        imageView.center = view.center
//        view.addSubview(imageView)
//        self.view.sendSubview(toBack: imageView)
//    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        
//        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
//            
//            let orient = UIApplication.shared.statusBarOrientation
//            
//            switch orient {
//                
//            case .portrait:
//                
//                print("Portrait")
//           //     self.assignbackground()
//                
//            case .landscapeLeft,.landscapeRight :
//                
//                print("Landscape")
//             //   self.assignbackground()
//                
//            default:
//                
//                print("Anything But Portrait")
//          //      self.assignbackground()
//            }
//            
//        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
//            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
//            
//        })
//        super.viewWillTransition(to: size, with: coordinator)
//        
//    }



//Keyboard
    //MARK: Keyboard will show
//    func keyboardWillShowWithNotification(notification: Notification)
//    {
//        print("The keyboard has appeared")
//        //print(notification.description)
//
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
//        
//        var contentInset:UIEdgeInsets = self.scrollView.contentInset
//        contentInset.bottom = keyboardFrame.size.height
//        self.scrollView.contentInset = contentInset
//    }
//    
//    
//    func keyboardWillHideWithNotification(notification: Notification)
//    {
//        print("The keyboard has disappeared")
//     //   print(notification.description)
//
//    }
    

}
