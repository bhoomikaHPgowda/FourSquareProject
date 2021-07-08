//
//  HomePageViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//



import UIKit
import MapKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    var signInVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NearYouViewController") as! NearYouViewController
    var popularViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopularViewController")  as! PopularViewController
    var detailViewModel = FetchPlaceDetailViewModel()
   
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
        
        
        
        
//        signInVc.loc(lat: 123.56)
//        add(asChildViewController: self.signInVc, index: 0, finished: {
//           // signInVc.add()
//            signInVc.loc(lat: 123.56)
//        })
//        signInVc.loc(lat: 123.56)
       
    }
    
    func fetchDataForNearViewController(latitude: Double, longitude: Double) {
        
        detailViewModel.fetchDetails(latitude: latitude, longitude: longitude, optionType: .nearYour, complitionHandler: {
            
            details
            in
        
            DispatchQueue.main.async {
                
                self.remove(asChildViewController: self.popularViewController)
                print("c1")
                print("near you count==\(details.count)")
              //  self.popularViewController.index = 102
                self.signInVc.details1 = details
                //self.signInVc.nearYouTableView.reloadData()
              //  self.popularViewController.added()
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
        //sideMenu.isHidden = false
        view.window!.layer.add(CATransition.transitionLeftToRight(), forKey: kCATransition)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomePageCollectionViewCell {
            
           cell.buttonName.text = "\(values[indexPath.row])"
          
            return cell
        }
        
        return HomePageCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
        let width = view.frame.size.width
 
        return CGSize(width: view.frame.width / 5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell did selected \(indexPath)")
        guard let location = locationManager.location?.coordinate else {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! HomePageCollectionViewCell
            cell.buttonName.textColor = UIColor.colorForHighlightedLabel()
        guard let option = cell.buttonName.text else {
            print("wrong locatiojjjsjjdjdjdjdjdd")
            return
        }
        if indexPath == selectindexpath {
            
            add(asChildViewController: signInVc, index: 0, finished: {})
        } else if option == CollectionViewOptions.popular.rawValue{
            print("popular is selectef")
            remove(asChildViewController: signInVc)
            detailViewModel.fetchDetails(latitude: location.latitude, longitude: location.longitude, optionType: .popular, complitionHandler: {
            
                details
                in
            
                DispatchQueue.main.async {
                    
                    self.remove(asChildViewController: self.popularViewController)
                    print("c1")
                    print("popular count==\(details.count)")
                    self.popularViewController.index = 102
                    self.popularViewController.details = details
                    self.popularViewController.added()
                    self.add(asChildViewController: self.popularViewController, index: 1, finished: {self.popularViewController.added()
                        print("data for popular")
                        self.popularViewController.popularListTableView.reloadData()
                    })
                }
                
                
            })
            
    
        } else if option == CollectionViewOptions.topPick.rawValue{
            detailViewModel.fetchDetails(latitude: location.latitude, longitude: location.longitude, optionType: .topPick, complitionHandler: {
                
                details
                in
                
                DispatchQueue.main.async {
                    print("toppick count==\(details.count)")
                    self.remove(asChildViewController: self.popularViewController)
                    print("c1")
                    self.popularViewController.index = 106
                    self.popularViewController.details = details
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
        let cell = collectionView.cellForItem(at: indexPath) as! HomePageCollectionViewCell
            cell.buttonName.textColor = UIColor.colorForNormalLabel()
//        collectionView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UICollectionView.RowAnimation.None)
        collectionView.reloadItems(at: [indexPath])
        
        
        
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
    
}

extension HomePageViewController: DismissSideMenu {
    func sidemenuSelectedOption(option: SideMenuOption) {
        print("pressed \(option.rawValue)")
       
        if option == .favourite {
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "\(option.rawValue)") as! FavouritesViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
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
        print("locatuiajfcjsafjdskfjhdskjhfksdhjfsdfksdfkhdskfhjsdkff")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.first, location != nil {
          //  print("location:: \(locations)")
            fetchDataForNearViewController(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        
        if let location = locations.first {
            print("-----------45869045860546546456546456546546456")
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
           addddd()
           
        }

    }
}
