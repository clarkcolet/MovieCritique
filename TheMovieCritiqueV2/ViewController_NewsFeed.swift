//
//  ViewController_NewsFeed.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 10/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewController_NewsFeed: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate
{
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!

    @IBOutlet weak var collectionMovies: UICollectionView!
    @IBOutlet weak var buttonProfile: UIBarButtonItem!
    @IBOutlet weak var buttonSearch: UIBarButtonItem!
    //CollectionView
    let reuseIdentifier = "cellPosterTop"
    //Table View
    let tableCellIdentifier = "tableActivity"
    
    var currentCellExternal = CollectionViewMovies()
    
    
    var items = ["beauty", "startrek", "guardians"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let cellSize = CGSize(width:300 , height:400)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        collectionMovies.setCollectionViewLayout(layout, animated: true)
        
        collectionMovies.reloadData()
        
       // let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
       // layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
      //  layout.minimumInteritemSpacing = 0
      //  layout.minimumLineSpacing = 0
       // collectionMovies!.collectionViewLayout = layout
    //    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
     //   let width = UIScreen.main.bounds.width
      //  layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
     //   layout.itemSize = CGSize(width: width / 3, height: width / 3)
       // layout.minimumInteritemSpacing = 0
       // layout.minimumLineSpacing = 0
     //   collectionMovies!.collectionViewLayout = layout
        
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.items.count)
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cellPosterTop = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewMovies
        
        cellPosterTop.moviePoster.image = UIImage(named: items[indexPath.row])
        // cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        print("I got here")
        return cellPosterTop
    }
    
    
   // func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
   //     let totalCellWidth = Int(collectionView.layer.frame.size.width) / 3 * collectionView.numberOfItems(inSection: 0)
     //   let totalSpacingWidth = (collectionView.numberOfItems(inSection: 0) - 1)
        
      //  let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
    //    let rightInset = leftInset
        
     //   return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
  //  }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        //let indexPath = collectionView.indexPathForSelectedRow() //optional, to get from any UIButton for example
        
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewMovies
        currentCellExternal = currentCell
        
        performSegue(withIdentifier: "FromHomeToMovie", sender: nil)
     
      //  print(currentCell.textLabel!.text)
        //Code here
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "movie") as! MovieDetailsViewController
//        vc.titleMovieExternal = "Beauty and the Beast"
//        vc.actorsExternal = "Emma Watson"
//        vc.moviePosterExternal = UIImage(named: "beauty")
//        
//        self.present(vc, animated: true, completion: nil)
        
        //
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromHomeToMovie"{

        let vc = segue.destination as! ViewControllerMovie
      
            vc.externalMovieImage = currentCellExternal.moviePoster.image
            vc.externalMovieDescription = "_____"
            vc.externalMovieTitle = "----"
            vc.externalMovieDescription = "1234"
            vc.externalMovieActors = "12345678"
            vc.externalMovieGenre = ""
         
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Table views
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print("about to enter")
        return 1
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("I got at the beginning of the feed thig")
        let tableActivity = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! TableViewCellMovies
        //cellTable.tableLabelTime.text = "5 minutes ago"
        tableActivity.imageProfile.image = UIImage(named: "Account")
        tableActivity.imagePoster.image = UIImage(named: "startrek")
        tableActivity.labelTitle.text = "Star Trek"
        tableActivity.labelUserActivity.text = "John C. made a review:"
        tableActivity.textView.text = "Good film. Worth watching"
       // print("I got at the end of the feed thing")
        return tableActivity
        
    }
    
    

}
