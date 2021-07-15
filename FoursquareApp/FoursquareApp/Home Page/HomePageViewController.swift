//
//  HomePageViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//



import UIKit
import MapKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var trailingEdge: NSLayoutConstraint!
    @IBOutlet weak var leadingEdge: NSLayoutConstraint!
    @IBOutlet weak var containerViewforPopular: UIView!
    @IBOutlet weak var collectionViewForHome: UICollectionView!
    @IBOutlet weak var nearYouContainerView: UIView!
    
    let values: [String] = CollectionViewOptions.allCases.map { $0.rawValue }
    let locationManager = CLLocationManager()
    var selectedCellIndexPath = [IndexPath] ()
    var selectindexpath: IndexPath = [0, 0]
    var detailViewModel = FetchPlaceDetailViewModel()
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: " ", email: " ", token: " ", userName: " ")
    var user: UserDetail?
    var signInVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NearYouViewController") as! NearYouViewController
    var popularViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopularViewController")  as! PopularViewController
    var filterViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
   
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        self.collectionViewForHome.delegate = self
        self.collectionViewForHome.dataSource = self
        collectionViewForHome.autoresizesSubviews = false
        sideMenu.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        print("\(userDetails.email) is received")
        statusBarSetup()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func statusBarSetup() {
        
        if #available(iOS 13.0, *) {
                    let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor.statusBarColor()
            statusBar.tintColor = .white
                    UIApplication.shared.keyWindow?.addSubview(statusBar)
                } else {
                     UIApplication.shared.statusBarView?.backgroundColor = UIColor.statusBarColor()
                    UIApplication.shared.statusBarView?.tintColor = UIColor.white
                }
    }
    
    func fetchDataForNearViewController(latitude: Double, longitude: Double) {
        print("called")
        detailViewModel.fetchDetails(latitude: latitude, longitude: longitude, optionType: .nearMe, complitionHandler: {
            
            details
            in
        
            DispatchQueue.main.async {
                
                self.remove(asChildViewController: self.popularViewController)
                self.signInVc.details1 = details
                self.signInVc.userDetails = self.userDetails
                self.signInVc.detailViewModel = self.detailViewModel
                self.signInVc.add(count: details.count)
                self.add(asChildViewController: self.signInVc, index: 0, finished: {
                    self.signInVc.add(count: details.count)
                    print("data for popular")
                    self.signInVc.nearYouTableView.reloadData()
                })
            }
            
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination  = segue.destination as? HambergerMenuViewController {
            
            destination.delegate = self
            destination.userDetails = userDetails
        } else {
            if (segue.identifier == "search") {
                print("segue called")
                if let destination  = segue.destination as? SearchCityViewController{
                   
                   destination.delegate = self
                  
               }
            }
        }
        
       
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionViewForHome.collectionViewLayout as? UICollectionViewFlowLayout else {
            
            return
        }
       
        flowLayout.invalidateLayout()
        collectionViewForHome.reloadData()
    }
    
    @IBAction func sideMenuTapped(_ sender: UIButton) {
        
        MainView.frame.origin.x = 260
        view.window!.layer.add(CATransition.transitionLeftToRight(), forKey: kCATransition)
    }
    
    @IBAction func filterTapped(_ sender: UIButton) {
        navigationController?.pushViewController(filterViewController, animated: true)
        filterViewController.cityName = "Udupi"
        filterViewController.completionHandler = { [self]
            data
            in
            print("data reciebed ==\(data.count)")
            signInVc.details1 = data
            signInVc.nearYouTableView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    

  
    @IBAction func optionSeleted(_ sender: CustomButtonForCollectionViewOptions) {
        
    }
    
    
    func add(asChildViewController viewController: UIViewController, index: Int, finished: () -> Void) {
        
        if index == 0 {
            
           // containerViewforPopular.alpha = 0
           // nearYouContainerView.alpha = 1
            addChild(viewController)
            containerViewforPopular.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            viewController.view.frame = containerViewforPopular.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            
        } else {
            
           // nearYouContainerView.alpha = 0
          //  containerViewforPopular.alpha = 1
            addChild(viewController)
            containerViewforPopular.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            viewController.view.frame = containerViewforPopular.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            finished()
            
            
        }
    }
    
     func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func addToFavouriteList(placeDetail: PlaceDetail) {
        
        detailViewModel.addOrDeleteFavourite(userId: userDetails.id, token: userDetails.token, placeId: placeDetail.placeId, requestMethod: .addToFavourite, completionHandler: {
            statusCode
            in
            print("added succefully\(statusCode)")
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.detailViewModel.favouritePlaceList!.append(placeDetail)
                }
                
            }
            
            
        })
    }
    
    func deleteFavouriteFromList(placeDetail: PlaceDetail) {
        
        detailViewModel.addOrDeleteFavourite(userId: userDetails.id, token: userDetails.token, placeId: placeDetail.placeId, requestMethod: .deleteFromFavourite, completionHandler: {
            statusCode
            in
            print("added succefully\(statusCode)")
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.detailViewModel.removeFavourite(placeid: placeDetail.placeId)
                }
            }
        })
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomePageCollectionViewCell {
            
           cell.buttonName.text = "\(values[indexPath.row])"
            if indexPath.row == 0 {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                cell.buttonName.textColor = .white
               
            } else {
                cell.buttonName.textColor = .gray
            }
            return cell
        }
        
        return HomePageCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
 
        return CGSize(width: view.frame.width / 5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell did selected \(indexPath)")
        
        guard let location = locationManager.location?.coordinate else {
            return
        }
      
        let cell = collectionView.cellForItem(at: indexPath) as! HomePageCollectionViewCell
          //  cell.buttonName.textColor = UIColor.colorForHighlightedLabel()
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        cell.buttonName.textColor = .white
        guard let option = cell.buttonName.text else {
          print("failed guard sleledvsdfg")
            return
        }
        print("option seleted===\(option)")
        if indexPath == selectindexpath {
            
            add(asChildViewController: signInVc, index: 0, finished: {})
        } else if option == CollectionViewOptions.popular.rawValue{
            print("popular is selectef")
            print("option seleted===\(option)")
            remove(asChildViewController: signInVc)
            detailViewModel.fetchDetails(latitude: location.latitude, longitude: location.longitude, optionType: .popular, complitionHandler: {
            
                details
                in
            
                DispatchQueue.main.async {
                    
                    self.remove(asChildViewController: self.popularViewController)
                    self.popularViewController.detailViewModel = self.detailViewModel
                    self.popularViewController.details = details
                    self.popularViewController.userDetails = self.userDetails
                    self.popularViewController.added()
                    self.add(asChildViewController: self.popularViewController, index: 1, finished: {
                        self.popularViewController.added()
                    
                        self.popularViewController.popularListTableView.reloadData()
                    })
                }
                
                
            })
            
    
        } else if option == CollectionViewOptions.topPick.rawValue{
            print("topick selectecd")
            print("option seleted===\(option)")
            detailViewModel.fetchDetails(latitude: location.latitude, longitude: location.longitude, optionType: .topPick, complitionHandler: {
                
                details
                in
                
                DispatchQueue.main.async {
                    print("toppick count==\(details.count)")
                    self.remove(asChildViewController: self.popularViewController)
                    print("c1")
                    self.popularViewController.index = 106
                    self.popularViewController.details = details
                    self.popularViewController.detailViewModel = self.detailViewModel
                    self.popularViewController.userDetails = self.userDetails
                    self.popularViewController.added()
                    self.add(asChildViewController: self.popularViewController, index: 1, finished: {self.popularViewController.added()
                        print("data for popular")
                        self.popularViewController.popularListTableView.reloadData()
                    })
                }
                
                
            })

        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deseleted")
        let cell = collectionView.cellForItem(at: indexPath) as! HomePageCollectionViewCell
            cell.buttonName.textColor = UIColor.colorForNormalLabel()

        //collectionView.reloadItems(at: [indexPath])
    }
    
    
}

extension HomePageViewController: DismissSideMenu {
    func sidemenuSelectedOption(option: SideMenuOption) {
        print("pressed \(option.rawValue)")
        
        if option == .favourite {
    
            detailViewModel.getFavouriteList(userId: userDetails.id, token: userDetails.token, completionHandler: {
                (favouriteList, statuscode)
                in
              
                    DispatchQueue.main.async {
                        let favouriteViewController = self.storyboard?.instantiateViewController(withIdentifier: "\(option.rawValue)") as! FavouritesViewController
                      //  favouriteViewController.favouriteList = favouriteList
                        favouriteViewController.detailViewModel = self.detailViewModel
                        favouriteViewController.user = self.userDetails
                        self.navigationController?.pushViewController(favouriteViewController, animated: true)
                    }
                
                
               
            })
         
        } else if option == .feedback {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "\(option.rawValue)") as! FeedbackViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
        } else if option == .aboutUs {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "\(option.rawValue)") as! AboutUsViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setConstraints() {
        print("protocol called")
        MainView.frame.origin.x = 0
    }
    
    

}

extension HomePageViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
       
        
    }
    func addddd() {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.first, location != nil {
          //  print("location:: \(locations)")
            
            detailViewModel.getFavouriteList(userId: userDetails.id, token: userDetails.token, completionHandler: {
                (favouriteList, statuscode)
                in
                
                    self.fetchDataForNearViewController(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
            })
        }
        
        if let location = locations.first {
    
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
           addddd()
           
        }

    }
}



extension HomePageViewController: UpdatefavouritesList {
    func deleteFavourite(placeDetail: PlaceDetail) {
        deleteFavouriteFromList(placeDetail: placeDetail)
    }
    
    func isFavourite(placeDetail: PlaceDetail) -> Bool {
        return detailViewModel.isFavourite(placeId: placeDetail.placeId)
    }
    
    func addToFavouirtes(placeDetail: PlaceDetail) {
        print("12343343555  -----\(placeDetail.address)")
        addToFavouriteList(placeDetail: placeDetail)
    }
    
    
}
