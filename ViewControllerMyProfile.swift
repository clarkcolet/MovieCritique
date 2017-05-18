
//  Created by Claudio Coletta on 12/05/2017.
//  Copyright © 2017 CCNN. All rights reserved.
//

import UIKit

class ViewControllerMyProfile: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var buttonReviews: UIButton!
    @IBOutlet weak var buttonFavourites: UIButton!
    
    @IBOutlet weak var labelUnderline: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelMovie: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var buttonProfile: UIButton!
    
    
    var collectionView: UICollectionView!
    var tableView: UITableView!
    
    var navigationTitleExternal:String!
    var externalLabel:String!
    var reviews:Bool = false
    var tableViewFirstTime:Bool = true
    
    var currentCellExternal = CollectionViewCellReviews()
    var currentRowExternal = TableViewCellReviews()
    
    var boolRow:Bool = false
    var boolRight:Bool = true
    
    var externalProfilePhoto:UIImage!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var tasks: [UserImage] = []

    
    override func viewDidLoad() {
     
        
        
        super.viewDidLoad()
     
        self.title = "My Profile"
     
         self.navigationController?.navigationBar.tintColor = UIColor.black;
        buttonFavourites.setTitleColor(UIColor.black, for: UIControlState.normal)

        buttonReviews.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        labelUnderline.textColor = UIColor.black
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 200, height: 320)
        
        //  print(subView.frame.width)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCellReviews.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.lightGray
        subView.addSubview(collectionView)
       

        
        buttonProfile.layer.cornerRadius = 0.5 * buttonProfile.bounds.size.width
        buttonProfile.layer.borderColor = UIColor.black.cgColor//UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0, alpha:1).cgColor as CGColor
        buttonProfile.layer.borderWidth = 4
        buttonProfile.clipsToBounds = true
    
        getData()

        
    }
  

    
    func getData() {
        print("Attempt to try to enter tasks count \(tasks.count)")
        
                do {
                    tasks = try context.fetch(UserImage.fetchRequest())
               
                    print(tasks.count)
                } catch {
                    print("Fetching Failed")
                }
        
        if(tasks.count > 0) {
            let task = tasks[0]
            
            buttonProfile.setImage(UIImage(data: task.imageData! as Data), for: .normal)
            
            
            
            print("I'm here inside tasks count")
        }

    }
    

    
    func loadCollectionView(){
        
        collectionView.removeFromSuperview()
        if(!tableViewFirstTime) {
            tableView.removeFromSuperview()
        }
        
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 200, height: 320)
        
        //  print(subView.frame.width)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: subView.frame.width, height: subView.frame.height), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.lightGray
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
        boolRow = true
        let currentRow = tableView.cellForRow(at: indexPath) as! TableViewCellReviews
        currentRowExternal = currentRow
        
        performSegue(withIdentifier: "FromMyProfileToReview", sender: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath as IndexPath) as! TableViewCellReviews
        cell.imageMovie.image = UIImage(named: "beauty")
        cell.movieTitle.text = "hello, mate"
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
        boolRow = false
    
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCellReviews
        currentCellExternal = currentCell
        
        performSegue(withIdentifier: "FromMyProfileToReview", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromMyProfileToReview"{
            
            let vc = segue.destination as! ViewControllerMyReview
            
            if(!boolRow) {
                vc.externalImage = currentCellExternal.imageView.image
                vc.externalReview = "My review goes here - collection"
                vc.externalDescription = "Description goes here"
                vc.externalTitle = "Title goes here"
            } else {
                vc.externalImage = currentRowExternal.imageMovie.image
                vc.externalReview = "My review goes here - table"
                vc.externalDescription = "Description goes here"
                vc.externalTitle = "Title goes here"
            }
            vc.title = "Review"
            
            
        }
    }
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        var session = SessionManager()
        session.DestroySession()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(vc!, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showReviews(_ sender: UIButton) {
        print("reviews pressed")
        reviews = true
        buttonReviews.setTitleColor(UIColor.black, for: UIControlState.normal)

        buttonFavourites.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
   
        loadTableView()
        if(boolRight){
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.labelUnderline.frame.origin.x -= 512
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        boolRight = false
    }
    
    @IBAction func showFavourites(_ sender: UIButton) {
        print("favourites pressed")
      
        reviews = false
        buttonFavourites.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        buttonReviews.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        
        if(!boolRight) {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.labelUnderline.frame.origin.x += 512
                self.view.layoutIfNeeded()
            }, completion: nil)
        }

        boolRight = true
        loadCollectionView()
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
         print ("Right")
        if(!boolRight){
        showFavourites(buttonFavourites)
        }
    }
    
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if(boolRight){
            showReviews(buttonReviews)
        }
        
    }
    
    func storeProfilePhoto() {
        
        print("Photo stored")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        //
        for taskDelete in tasks {
            print("Deleting)!")
            context.delete(taskDelete)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                tasks = try context.fetch(UserImage.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        //
        
//        let taskDelete = tasks[0]
//        context.delete(taskDelete)
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//        
//        do {
//            tasks = try context.fetch(UserImage.fetchRequest())
//        } catch {
//            print("Fetching Failed")
//        }
        
        
        let task = UserImage(context: context) // Link Task & Context
        task.imageData = UIImagePNGRepresentation(externalProfilePhoto) as NSData?//externalProfilePhoto

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        getData()
        
    }

    @IBAction func changePhoto(_ sender: UIButton) {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let optionPhoto = self.storyboard?.instantiateViewController(withIdentifier: "Photo") as! ViewControllerPhoto
        
        optionPhoto.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popoverMenuViewController = optionPhoto.popoverPresentationController
        popoverMenuViewController!.permittedArrowDirections = .up
        popoverMenuViewController!.delegate = self as? UIPopoverPresentationControllerDelegate
        popoverMenuViewController!.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(x:buttonProfile.frame.origin.x + 3, y: buttonProfile.frame.origin.y + 110,width: 100, height: 50)
        
        optionPhoto.preferredContentSize = CGSize(width: 200, height: 120)
        optionPhoto.externalMyProfile = self
        optionPhoto.boolExternalCreateAccount = false
        self.present(optionPhoto, animated: true, completion: nil)
      //  getData()
        
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

