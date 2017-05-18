//
//  ViewControllerPhoto.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 17/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerPhoto: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var externalMyProfile = ViewControllerMyProfile()
    var externalCreateAccount = ViewControllerCreateAccount()
    let imagePicker = UIImagePickerController()
    var boolExternalCreateAccount = Bool()


    override func viewDidLoad() {
        super.viewDidLoad()
         imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        print("Image Pick Controller")
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
        if(!boolExternalCreateAccount) {
        externalMyProfile.buttonProfile.setImage(chosenImage, for: .normal)
        externalMyProfile.buttonProfile.contentMode = .scaleAspectFit
        //
        externalMyProfile.externalProfilePhoto = chosenImage
        externalMyProfile.storeProfilePhoto()
        //
        
        } else {
            externalCreateAccount.buttonProfile.setImage(chosenImage, for: .normal)
            externalCreateAccount.buttonProfile.contentMode = .scaleAspectFit
            //
            externalCreateAccount.externalProfilePhoto = chosenImage
            externalCreateAccount.storeProfilePhoto()
        }
        dismiss(animated:true, completion: nil)
        
        let tmpController :UIViewController! = self
        
        
        self.dismiss(animated: false, completion: {()->Void in
            print("done");
            tmpController.dismiss(animated: false, completion: nil);
        });
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      //  dismiss(animated: true, completion: nil)
        let tmpController :UIViewController! = self
        
        
        self.dismiss(animated: false, completion: {()->Void in
            print("done");
            tmpController.dismiss(animated: false, completion: nil);
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func selectCamera(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        

        guard case imagePicker.sourceType = UIImagePickerControllerSourceType.camera else{
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            let alertVC = UIAlertController(title: "Error", message: "Can't access camera", preferredStyle: .alert)
            
            alertVC.addAction(alertAction)
            
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker,animated: true,completion: nil)
        
    }
    
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
