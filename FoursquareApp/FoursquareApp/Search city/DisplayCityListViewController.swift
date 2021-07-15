//
//  DisplayCityListViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 03/07/21.
//

import UIKit

protocol SendFavouriteRestaurentDetail {
    
    func sendAddToFavouirteData(placeDetail: PlaceDetail)
    func isFavourite(placeDetail: PlaceDetail)-> Bool
    func sendDeleteFavourite(placeDetail: PlaceDetail)
}

class DisplayCityListViewController: UIViewController {


    @IBOutlet weak var placeList: UITableView!
    var placedetail: [PlaceDetail]?
    var searchViewModel = SearchViewModel()
    var delegate: SendFavouriteRestaurentDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        placeList.delegate = self
        placeList.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mapView(_ sender: Any) {
        print("mapview called")
        
        print("dlefgate cakkkked")
        var displayMapViewViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayMapViewViewController") as! DisplayMapViewViewController
        if let detail = placedetail {
            displayMapViewViewController.data = detail
        }
        
        navigationController?.pushViewController(displayMapViewViewController, animated: true)
    }
    
    @IBAction func addToFavouritesTapped(_ sender: CustomAddToFavoriteButton) {
        if let addToFavoriteButton = sender as? CustomAddToFavoriteButton {
            
            addToFavoriteButton.toggle()
        }
        guard let data = placedetail else {
            return
        }
        if sender.isSelected {
            delegate?.sendAddToFavouirteData(placeDetail: data[sender.tag - 1] )
        } else {
            delegate?.sendDeleteFavourite(placeDetail: data[sender.tag - 1])
        }
    }
    
}

extension DisplayCityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = placedetail else {
            return 0
        }
        print("dadad count ==\(data.count)")
        return data.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchedCityTableViewCell {
            guard let data = placedetail else {
                return SearchedCityTableViewCell()
            }
         
            cell.placeName.text = data[indexPath.row].placeName
            cell.rating.text = String(data[indexPath.row].rating.rounded(places: 1))
            cell.address.text = data[indexPath.row].address
            cell.layer.borderColor = UIColor.colorForCellSpace().cgColor
            cell.address.textColor = .darkGray
            cell.detail.textColor = .darkGray
            cell.layer.borderWidth = 3
            cell.rating.backgroundColor = UIColor.ratingColor(rating: data[indexPath.row].rating)
            cell.detail.text = "\(data[indexPath.row].placeType.components(separatedBy:" ")[0]) " + " \u{2022} " + String(repeating: "\u{20B9}", count: data[indexPath.row].cost) + " \(round(data[indexPath.row].distance))Km"
            cell.placeImage.image = searchViewModel.fetchImageForGivenPlace(url: data[indexPath.row].imageUrl)
            cell.addToFavourite.tag = indexPath.row + 1


            if let isFavourite = delegate?.isFavourite(placeDetail: data[indexPath.row]), isFavourite == true {
                print("isFavouirtes")
                cell.addToFavourite.isSelected = true
            } else {
                cell.addToFavourite.isSelected = false
            }
           return cell
        } else {
            return SearchedCityTableViewCell()
            
        }
        
    }
}
