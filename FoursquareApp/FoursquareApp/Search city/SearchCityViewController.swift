//
//  SearchCityViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 03/07/21.
//

import UIKit

class SearchCityViewController: UIViewController {

    @IBOutlet weak var nearMeOptionView: UIView!
    @IBOutlet weak var displaySeachList: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var search: CustomSearchBar!
    @IBOutlet weak var nearMe: CustomSearchBar!
    var viewModel = SearchViewModel()
    var userDetails: UserDetail?
    var name: String?
    var emptySearchScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchEmptyViewController") as! SearchEmptyViewController
    var searchScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")  as! SearchViewController
    var displayScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayCityListViewController")  as! DisplayCityListViewController
    
    var nearMeOptionScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowNearMeOptionViewController")  as! ShowNearMeOptionViewController
    
    var filterScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterViewController")  as! FilterViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearMe.setImage(UIImage(named: "map"), for: .search, state: .normal)
        search.setImage(UIImage(named: "searcgIcon"), for: .search, state: .normal)
        search.delegate = self
        nearMe.delegate = self
        add(viewController: emptySearchScreen, mode: .emptyScreen)
        print(name)
        print("userDetails?.email = \(String(describing: userDetails?.email))")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func filter(_ sender: UIButton) {
        if let city = search.text {
            filterScreen.cityName = city
            filterScreen.completionHandler = { [self]
                data
                in
                
                    print("received data from filter \(data.count)")
                    displayScreen.placedetail = data
                    displayScreen.placeList.reloadData()
                
                
                
            }
            
        }
        
        navigationController?.pushViewController(filterScreen, animated: true)
    }
    
    @IBAction func back(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    

    func add(viewController: UIViewController, mode: SearchScreen) {
    
        if mode == .emptyScreen {
           // searchView.alpha = 0
          //  emptyView.alpha = 1
            displaySeachList.alpha = 0
            nearMeOptionView.alpha = 0
            addChild(viewController)
            emptyView.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            viewController.view.frame = emptyView.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        } else {
            print("adddded")
            //searchView.alpha = 1
           // searchView.alpha = 0
            
            addChild(viewController)
            emptyView.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            viewController.view.frame = searchView.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
     func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("pressed")
      //  remove(asChildViewController: emptySearchScreen)
        searchScreen.name = "sushanth"
        if searchBar.tag == 1 {
            add(viewController: searchScreen, mode: .searchScreen)
            search.setShowsScope(true, animated: false)
        } else {
            add(viewController: nearMeOptionScreen, mode: .searchScreen)
            search.setShowsScope(true, animated: false)
        }
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("end")
        searchBar.resignFirstResponder()
        guard let place = searchBar.text else {
            print("search bar error")
            return
        }
        print("place == \(place)")
        viewModel.fetchSearchedCityDetail(placeName: place, completionHanlderL: {
            photoDetails
            in
            DispatchQueue.main.async {
                self.displayScreen.userDetails = self.userDetails
                self.displayScreen.placedetail = photoDetails
                self.add(viewController: self.displayScreen, mode: .searchScreen)
                self.displayScreen.placeList.reloadData()
            } 
            
        })
        
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        
        print("cakeed")
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText == "\n" {
            print("svsdvdsvsvs")
            searchBar.resignFirstResponder()
            
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search is clicked")
        searchBar.resignFirstResponder()
       // add(viewController: displayScreen, mode: .searchScreen)
    }
    
    
}
