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

    @IBOutlet weak var phoneNumber: UITextField!
    
     @IBOutlet weak var buttonProfile: UIButton!
    
    var genre:String!
    
    var externalProfilePhoto:UIImage!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [UserImage] = []
    
    var pickerData: [String] = [String]()
    
    let validator = Validator()
    let sessionM = SessionManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonProfile.setImage(UIImage(named: "Account") , for: .normal)
       // let task = UserImage(context: context) // Link Task & Context
       // task.imageData = UIImagePNGRepresentation(externalProfilePhoto) as NSData?//externalProfilePhoto
        
       // (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //
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
        
   
        buttonProfile.layer.cornerRadius = 0.5 * buttonProfile.bounds.size.width
        buttonProfile.layer.borderColor = UIColor.black.cgColor//UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0, alpha:1).cgColor as CGColor
        buttonProfile.layer.borderWidth = 4
        buttonProfile.clipsToBounds = true
        
       // getData()

        
    }
    
    func getData() {
        print("Attempt to try to enter tasks count \(tasks.count)")
        
        do {
            tasks = try context.fetch(UserImage.fetchRequest())
            
            print(tasks.count)
        } catch {
            print("Fetching Failed")
        }
        
        if(tasks.count > 0) {
            let task = tasks[tasks.count - 1]
            
            buttonProfile.setImage(UIImage(data: task.imageData! as Data), for: .normal)
            
            
            
            print("I'm here inside tasks count")
        }
        
    }
    
    func storeProfilePhoto() {
        
        print("Photo stored")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //
        for taskDelete in tasks {
            print("Deleting)!")
            context.delete(taskDelete)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                tasks = try context.fetch(UserImage.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        let task = UserImage(context: context) // Link Task & Context
        task.imageData = UIImagePNGRepresentation(externalProfilePhoto) as NSData?//externalProfilePhoto
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        getData()
        
    }
    
    @IBAction func changePhoto(_ sender: UIButton) {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let optionPhoto = self.storyboard?.instantiateViewController(withIdentifier: "Photo") as! ViewControllerPhoto
        
        optionPhoto.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popoverMenuViewController = optionPhoto.popoverPresentationController
        popoverMenuViewController!.permittedArrowDirections = .up
        popoverMenuViewController!.delegate = self as? UIPopoverPresentationControllerDelegate
        popoverMenuViewController!.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(x:buttonProfile.frame.origin.x + 3, y: buttonProfile.frame.origin.y + 110,width: 100, height: 50)
        
        optionPhoto.preferredContentSize = CGSize(width: 200, height: 120)
        optionPhoto.externalCreateAccount = self
        optionPhoto.boolExternalCreateAccount = true
        self.present(optionPhoto, animated: true, completion: nil)
        
        
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
        genre = pickerData[row]
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
            let alert = UIAlertController(title: "Error in Password", message: "Password is less than 6 characsters", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
        else if ConfirmPasswordTxt.text != PasswordTxt.text
        {
            validator.AnimationShakeTextField(textField: ConfirmPasswordTxt)
            confirmPasswordValid = false
        }
        else
        {
          ///  validator.AnimationShakeTextField(textField: ConfirmPasswordTxt)
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
            if(genre == nil) {
                genre = "Action"
            }
            startCreating(email: EmailTxt.text!, password: PasswordTxt.text!, firstname: FirstNameTxt.text!, lastname: LastNameTxt.text!, favouritegenre: genre!, favouritemovie: FavouriteMovie.text!, mobileno: phoneNumber.text!)
        }
        
    }
    
    func startCreating(email:String,password:String,firstname:String,lastname:String,favouritegenre:String,favouritemovie:String,mobileno:String)
    {
        let param:Dictionary<String,String> = ["Email" : self.EmailTxt.text! as String, "Password" : self.PasswordTxt.text! as String,
            "FirstName" : self.FirstNameTxt.text! as String,
            "LastName" : self.LastNameTxt.text! as String,
            "MobileNo" : self.phoneNumber.text! as String, //not implemented
            "FavouriteGenre" : self.genre as String,
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
                       
                        
                    }
                    DispatchQueue.main.async(execute: {
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNav")
                        self.present(vc!, animated: true, completion: nil)
                        
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
