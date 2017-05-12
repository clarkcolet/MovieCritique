//
//  ViewControllerFriendProfile.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 12/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerFriendProfile: UIViewController {

    var navigationTitleExternal:String!
    var externalLabel:String!
    
    @IBOutlet weak var innerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationTitleExternal
        innerLabel.text = externalLabel
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
