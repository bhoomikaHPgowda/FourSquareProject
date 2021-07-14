//
//  DisplayCityListViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 03/07/21.
//

import UIKit

class DisplayCityListViewController: UIViewController {


    @IBOutlet weak var placeList: UITableView!
    var placedetail: [PlaceDetail]?
    var userDetails: UserDetail?
    var searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        placeList.delegate = self
        placeList.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mapView(_ sender: Any) {
        var displayMapViewViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayMapViewViewController") as! DisplayMapViewViewController
        if let detail = placedetail {
            displayMapViewViewController.data = detail
        }
        navigationController?.pushViewController(displayMapViewViewController, animated: true)
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
        
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(detailViewController, animated: true)
        if let data = placedetail {
            guard let value = userDetails else{
                return
            }
            detailViewController.userDetails = value
            detailViewController.detail = data[indexPath.row]
        }
    
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
            cell.detail.text = "\(data[indexPath.row].placeType.components(separatedBy:" ")[0]) " + " \u{2022} " + String(repeating: "\u{20B9}", count: data[indexPath.row].cost) + " \(round(Double(data[indexPath.row].cost)))Km"
            cell.placeImage.image = searchViewModel.fetchImageForGivenPlace(url: data[indexPath.row].imageUrl)
            print(data[indexPath.row].distance)

//            cell.addToFavourite.tag = indexPath.row + 1
//            if detailViewModel.isFavourite(placeId: data[indexPath.row].placeId) {
//                cell.addToFavourite.isSelected = true
//            } else {
//                cell.addToFavourite.isSelected = false
//            }
           return cell
        } else {
            return SearchedCityTableViewCell()
            
        }
        
    }
}
