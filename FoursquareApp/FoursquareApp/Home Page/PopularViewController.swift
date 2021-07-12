//
//  PopularViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//

import UIKit

class PopularViewController: UIViewController {
    var index: Int?
    var count = 10
    var details: [PlaceDetail]?
    var detailViewModel = FetchPlaceDetailViewModel()
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: " ", email: " ", token: " ", userName: " " )
    @IBOutlet weak var popularListTableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var address: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularListTableView.delegate = self
        popularListTableView.dataSource = self
        print("user -----------\(userDetails.email)")
    }
    func added() {
        if let index = index {
            count = index
           // popularListTableView.reloadData()
        }
        print(index)
       // popularListTableView.reloadData()
    }
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    func reloads() {
        popularListTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return details?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = details {
            
            let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            self.navigationController?.pushViewController(detailViewController, animated: true)
            if let data = details {
                detailViewController.userDetails = userDetails
                detailViewController.detail = data[indexPath.row]
            }
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PopularTableViewCell {
            guard let data = details
            else {
                return PopularTableViewCell()
            }
            let dataForIndex = data[indexPath.row]
            cell.name.text = dataForIndex.placeName
            cell.rating.text = "\(round(dataForIndex.rating))"
            cell.detail.text = "\(dataForIndex.placeType.components(separatedBy:" ")[0]))" + " \u{2022} " + String(repeating: "\u{20B9}", count: dataForIndex.cost) + "  \(round(dataForIndex.distance))Km"
            cell.address.text = dataForIndex.address
            cell.placeImage.image = detailViewModel.fetchImageForGivenPlace(url: dataForIndex.imageUrl)
            cell.layer.borderColor = UIColor.colorFoeCellSpace().cgColor
            cell.address.tintColor = UIColor.colorForControlSegmentMormalState()
            cell.detail.textColor = .darkGray
            cell.address.textColor = .darkGray
               cell.layer.borderWidth = 3
            if detailViewModel.isFavourite(placeId: dataForIndex.placeId) {
                cell.addToFavouriteButton.isSelected = true
            } else {
                cell.addToFavouriteButton.isSelected = false
            }
            return cell
        } else {
            
            return PopularTableViewCell()
        }
    }
}

