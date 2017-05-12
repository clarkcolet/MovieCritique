//
//  ViewControllerNavigationExample.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 09/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerNavigationExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func fourFiveToggleButton(_ sender: UIButton){
      //  let normal = UIControlState(rawValue: 0) 
        print("hello")
        if sender.titleLabel?.text == "Button"{
            print("I'm in")
            performSegue(withIdentifier: "Four",
                         sender: self)
          //  sender.setTitle("Five", for: normal)
        }
    }
    


}
