//
//  ViewController.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 08/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var buttonLogin: UIButton!

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
    

}

