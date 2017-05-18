//
//  ViewControllerGenreList.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 14/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit


class ViewControllerGenreList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "cellGenre"
    var genres = ["Action", "Comedy", "Documentary", "Drama", "Family",  "Horror", "Thriller"]
    
    var externalMovieList = ViewControllerMovieList()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.genres.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cellGenre = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCellGenres
    
       cellGenre.labelGenre.text = genres[indexPath.row]
       cellGenre.layer.borderWidth = 1.0
       cellGenre.layer.borderColor = UIColor.gray.cgColor
        return cellGenre
        
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        print("You selected row: \(row) ")
        
        let currentCell = tableView.cellForRow(at: indexPath) as! TableViewCellGenres


        let tmpController :UIViewController! = self

       self.dismiss(animated: false, completion: {()->Void in
           print("done");
            tmpController.dismiss(animated: false, completion: nil);
        });
        
        externalMovieList.assignbackground()
        externalMovieList.navigationItem.title = currentCell.labelGenre.text
        externalMovieList.filterContentForSearchText(searchText: currentCell.labelGenre.text!)
        
     //   let filteredArray = externalMovieList.movies.filter() {contains(($0 as Movie).genre, currentCell.labelGenre.text)}
       
       
    
    
    func filterContentForSearchText(searchText: String) -> [Movie] {
        var results = [Movie]()
        for publication in externalMovieList.movies {
            if let fullTitle = publication.genre {
                if (fullTitle).contains(searchText) {
                    results.append(publication)
                }
            }
        }
        return results
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
}
