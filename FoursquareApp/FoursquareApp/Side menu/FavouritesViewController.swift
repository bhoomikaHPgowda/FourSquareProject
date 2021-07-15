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
    var detailViewModel = FetchPlaceDetailViewModel()
    var user: UserDetail?
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
    
    @IBAction func back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deletFavourite(_ sender: UIButton) {
    
        guard let userDetail = user else {
            return
        }
        detailViewModel.addOrDeleteFavourite(userId: userDetail.id, token: userDetail.token, placeId: detailViewModel.favouritesListAt(index: sender.tag)!.placeId, requestMethod: .deleteFromFavourite, completionHandler: {
                statusCode
                in
                print("deleted succefully\(statusCode)")
            DispatchQueue.main.async {
                if statusCode == 200 {
                    self.detailViewModel.removeFavourite(placeid: self.detailViewModel.favouritesListAt(index: sender.tag)!.placeId)
                    self.favouritesList.reloadData()
                }
            }
                
            })
            
        
        
    }
    
    
    
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.favouirteCount()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavouritesTableViewCell {
            if let favourites = detailViewModel.favouritesListAt(index: indexPath.row) {
                cell.name.text = favourites.placeName
                cell.rating.text = "\(favourites.rating.rounded(places: 1))"
                cell.rating.backgroundColor = UIColor.ratingColor(rating: favourites.rating)
                cell.address.text = favourites.address
                cell.detail.text = "\(favourites.placeType.components(separatedBy:" ")[0]) " + " \u{2022} " + String(repeating: "\u{20B9}", count: favourites.cost)
                cell.restaurentImage.image = UIImage.restaurentImage(url: favourites.imageUrl)
                cell.layer.borderColor = UIColor.colorForCellSpace().cgColor
                   cell.layer.borderWidth = 3
                cell.deleteFavouriteButton.tag = indexPath.row
                return cell
                
            } else {
                return FavouritesTableViewCell()
            }

        } else {
            
            return FavouritesTableViewCell()
        }
    }
}
