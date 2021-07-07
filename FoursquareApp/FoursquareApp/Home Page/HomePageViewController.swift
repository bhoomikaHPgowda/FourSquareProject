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
    var selectedCellIndexPath = [IndexPath] ()
    var selectindexpath: IndexPath = [0, 0]
    var signInVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NearYouViewController") as! NearYouViewController
    var signUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopularViewController")  as! PopularViewController
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewForHome.delegate = self
        self.collectionViewForHome.dataSource = self
        collectionViewForHome.autoresizesSubviews = false
        add(asChildViewController: signInVc, index: 0, finished: {})
        sideMenu.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
       
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
        let height = view.frame.size.height
        let width = view.frame.size.width
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
        let cell = collectionView.cellForItem(at: indexPath) as! HomePageCollectionViewCell
            cell.buttonName.textColor = UIColor.colorForHighlightedLabel()
        guard let option = cell.buttonName.text else {
            return
        }
        if indexPath == selectindexpath {
            add(asChildViewController: signInVc, index: 0, finished: {})
        } else if option == CollectionViewOptions.popular.rawValue{
            
            //remove(asChildViewController: signInVc)
            remove(asChildViewController: signUpVc)
            print("c1")
            signUpVc.index = 10
            signUpVc.added()
            add(asChildViewController: signUpVc, index: 1, finished: {signUpVc.added()
                signUpVc.popularListTableView.reloadData()
            })
    
        } else if option == CollectionViewOptions.topPick.rawValue{
          //  remove(asChildViewController: signInVc)
          //  remove(asChildViewController: signUpVc)
            print("c2")
            signUpVc.index = 2
            signUpVc.added()
            add(asChildViewController: signUpVc, index: 1, finished: {signUpVc.added()
                signUpVc.popularListTableView.reloadData()
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
