//
//  FavouritesViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 30/06/21.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var favouritesList: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var search: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let textfield = search.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            textfield.backgroundColor = UIColor.white
        }
        search.layer.cornerRadius = 5
        search.clipsToBounds = true
        favouritesList.delegate = self
        favouritesList.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavouritesTableViewCell {
            
            cell.name.text = "sushanth"
            cell.layer.borderColor = UIColor.colorFoeCellSpace().cgColor
               cell.layer.borderWidth = 3
            
            return cell
        } else {
            
            return FavouritesTableViewCell()
        }
    }
}
