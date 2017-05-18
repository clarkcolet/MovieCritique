//
//  ViewControllerTRYOUT.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 12/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices
import Foundation

class ViewControllerTRYOUT: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var subView: UIView!

    var collectionView: UICollectionView!
    
    @IBOutlet weak var labelLL: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //image.image: UIImage!

        imagePicker.delegate = self
  
       
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        
         collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height), collectionViewLayout: layout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        subView.addSubview(collectionView)

                   }
    
 
    
    /**
     Setup imagePicker and display Alert if it is not possible
     
     - parameter source: The Source for the imagePicker
     */
    func imagePickerSetup(forSource source : UIImagePickerControllerSourceType) {
        
        
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        if let pickedImage = init;[UIImagePickerControllerOriginalImage] as? UIImage; {
//            self.imageView.contentMode = .scaleAspectFit
//            imageView.image = imagePicker
//        }
//        
//       // dismissViewControllerAnimated(true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
//        
//    }

    
    
//    func importPicture() {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
//        present(picker, animated: true)
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
//        
//        dismiss(animated: true)
//        
//        imageView.image = image
//    }
//    
//    
//    @IBAction func addPhoto(_ sender: UIButton) {
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .photoLibrary
//        
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//
//    
//    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
//        print("swiping right")
//    }


    
    func assignbackground(){
        collectionView.removeFromSuperview()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        
        print(subView.frame.width)
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        subView.addSubview(collectionView)
        subView.reloadInputViews()
        
       

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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.orange
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     Convert Image to JPEG and generate a thumbnail
     
     - parameter image: a captured image
     */
    
    /**
     Display Alert when loadImages had no results
     */
//    func noImagesFound() {
//        
//        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        
//        let alertVC = UIAlertController(title: "No Images Found", message: "There were no images saved in Core Data", preferredStyle: .alert)
//        
//        alertVC.addAction(alertAction)
//        
//        self.present(alertVC, animated: true, completion: nil)
//    }
//
//    func startActivity() {
//        Run.main {
//            self.activityIndicator.isHidden = false
//            self.activityIndicator.startAnimating()
//        }
//    }
//    
//    func stopActivity() {
//        Run.main {
//            self.activityIndicator.isHidden = true
//            self.activityIndicator.stopAnimating()
//        }
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
