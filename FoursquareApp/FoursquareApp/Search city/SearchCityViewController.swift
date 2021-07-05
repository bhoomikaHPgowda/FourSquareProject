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
    var name: String?
    var emptySearchScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchEmptyViewController") as! SearchEmptyViewController
    var searchScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")  as! SearchViewController
    var displayScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayCityListViewController")  as! DisplayCityListViewController
    
    var nearMeOptionScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowNearMeOptionViewController")  as! ShowNearMeOptionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearMe.setImage(UIImage(named: "map"), for: .search, state: .normal)
        search.setImage(UIImage(named: "searcgIcon"), for: .search, state: .normal)
        search.delegate = self
        nearMe.delegate = self
        add(viewController: emptySearchScreen, mode: .emptyScreen)
        print(name)
        // Do any additional setup after loading the view.
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
        add(viewController: displayScreen, mode: .searchScreen)
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
