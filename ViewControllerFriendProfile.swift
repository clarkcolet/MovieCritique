//
//  ViewControllerFriendProfile.swift
//  TheMovieCritiqueV2
//
//  Created by Claudio Coletta on 12/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerFriendProfile: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var buttonReviews: UIButton!
    @IBOutlet weak var buttonFavourites: UIButton!
    
    @IBOutlet weak var labelFavourites: UILabel!
    @IBOutlet weak var labelReview: UILabel!
    
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelMovie: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var subView: UIView!
    var collectionView: UICollectionView!
    var tableView: UITableView!

    var navigationTitleExternal:String!
    var externalLabel:String!
    var reviews:Bool = false
    var tableViewFirstTime:Bool = true
    
    
    @IBOutlet weak var innerLabel: UILabel!
    
    override func viewDidLoad() {
         self.navigationController?.navigationBar.tintColor = UIColor.black;
        super.viewDidLoad()
        self.title = navigationTitleExternal
        innerLabel.text = externalLabel
        
       buttonFavourites.setTitleColor(UIColor.red, for: UIControlState.normal)
       labelFavourites.textColor = UIColor.red
        
       buttonReviews.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
       labelReview.textColor = UIColor.lightGray
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 200, height: 300)
        
      //  print(subView.frame.width)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCellReviews.self, forCellWithReuseIdentifier: "Cell")
        
        subView.addSubview(collectionView)
        
  
        // Do any additional setup after loading the view.
    }
    
    func loadCollectionView(){
       
        collectionView.removeFromSuperview()
        if(!tableViewFirstTime) {
        tableView.removeFromSuperview()
        }
        
       
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 200, height: 300)
        
      //  print(subView.frame.width)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCellReviews.self, forCellWithReuseIdentifier: "Cell")
        
        subView.addSubview(collectionView)
        
        subView.reloadInputViews()
      
  
    }
     // MARK: - TableView
    func loadTableView() {

        collectionView.removeFromSuperview()
        
        if(!tableViewFirstTime) {
            tableView.removeFromSuperview()
        }
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 300
      
        tableView.register(TableViewCellReviews.self, forCellReuseIdentifier: "ReviewCell")

        subView.addSubview(tableView)
        tableViewFirstTime = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I was selected: #\(indexPath.item)!")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath as IndexPath) as! TableViewCellReviews
        cell.imageUser.image = UIImage(named: "beauty")
        cell.reviewTitle.text = "hello, mate"
        cell.time.text = "2:00"
        cell.nameUser.text = "mark"
        cell.review.text = "Listening to dido.................................................................................................................................pkjljdfjldkvhsdvlkjhsdvlkndlkndsvlkadnvnkladvragaga"

        return cell
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
                if(!self.reviews)
                {
                self.loadCollectionView()
                } else
                {
                    self.loadTableView()
                }
                
            case .landscapeLeft,.landscapeRight :
                
                print("Landscape")
                if(!self.reviews) {
                    self.loadCollectionView()
                } else {
                    self.loadTableView()
                }
                
            default:
                
                print("Anything But Portrait")
                self.loadCollectionView()
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCellReviews
        
       
        cell.textLabel.text = "Beauty and the Beast"
        cell.imageView.image = UIImage(named: "beauty")

        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showReviews(_ sender: UIButton) {
        print("reviews pressed")
        reviews = true
        buttonReviews.setTitleColor(UIColor.red, for: UIControlState.normal)
        labelReview.textColor = UIColor.red
        
        buttonFavourites.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        labelFavourites.textColor = UIColor.lightGray
        loadTableView()
    }
    
    @IBAction func showFavourites(_ sender: UIButton) {
        
        
        print("favourites pressed")
        reviews = false
        buttonFavourites.setTitleColor(UIColor.red, for: UIControlState.normal)
        labelFavourites.textColor = UIColor.red
        
        buttonReviews.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        labelReview.textColor = UIColor.lightGray
        loadCollectionView()
        
//        
//        UIView.animate(withDuration: 0.5) {
//            self.buttonFavourites.center.x += self.buttonFavourites.bounds.width
//        }
//        
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
