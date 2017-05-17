//
//  ViewControllerMovie.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 15/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerMovie: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelActors: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    @IBOutlet weak var subViewInfo: UIView!
    
    
    var externalMovieTitle:String = ""
    var externalMovieImage:UIImage!
    var externalMovieActors:String = ""
    var externalMovieGenre:String = ""
    var externalMovieDescription:String = ""
    
    let tableCellIdentifier = "tableReviews"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black;

        labelTitle.text = externalMovieTitle
        imageMovie.image = externalMovieImage
        labelGenre.text = externalMovieGenre
        labelActors.text = externalMovieActors
        textViewDescription.text = externalMovieDescription
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Table views
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("about to enter")
        return 1
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("I got at....")
        let tableActivity = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! TableViewCellMovieReviews

        tableActivity.labelUserName.text = "Random name"
         print("I got at the end of the feed thing")
        return tableActivity
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
                // self.collectionMovies.removeFromSuperview()
              //  self.imageMovie.frame = CGRect(x: 0, y: 64, width: 349, height: 521)
                
            case .landscapeLeft,.landscapeRight :
                
                print("Landscape")
            //    self.imageMovie.frame = CGRect(x: 0, y: 64, width: 150, height: self.subViewInfo.frame.height)
               
           //     self.subViewInfo.sizeThatFits(200)
             //   self.subViewInfo.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               // self.subViewInfo.reloadInputViews()
             //   self.subViewInfo.frame = CGRect(x: 349, y: 64, width: 200, height: self.subViewInfo.frame.height)
              //  self.subViewInfo.frame = CGRect(x: , y: 177, width: self.view.bounds.width-200, height: self.subViewInfo.frame.height)
            default:
                print("Anything But Portrait")
   
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
