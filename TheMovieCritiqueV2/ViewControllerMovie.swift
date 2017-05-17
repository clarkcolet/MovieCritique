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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
