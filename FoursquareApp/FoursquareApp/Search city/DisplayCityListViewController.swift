//
//  DisplayCityListViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 03/07/21.
//

import UIKit

class DisplayCityListViewController: UIViewController {


    @IBOutlet weak var placeList: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DisplayCityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NearYouTableViewCell {
            
         
            cell.name.text = "sushanth"
//            cell.rating.text = "\(dataForIndex.rating.rounded(places: 1))"
//            cell.rating.backgroundColor = UIColor.ratingColor(rating: dataForIndex.rating)
//            cell.detail.text = "\(dataForIndex.placeType.components(separatedBy:" ")[0]) " + " \u{2022} " + String(repeating: "\u{20B9}", count: dataForIndex.cost) + " \(round(dataForIndex.distance))Km"
//
//
//            cell.address.text = dataForIndex.address
//            cell.placeImage.image = detailViewModel.fetchImageForGivenPlace(url: dataForIndex.imageUrl)
//            cell.layer.borderColor = UIColor.colorFoeCellSpace().cgColor
//            cell.address.textColor = .darkGray
//            cell.detail.textColor = .darkGray
//            cell.layer.borderWidth = 3
//            cell.addToFavouriteButton.tag = indexPath.row + 1
//            if detailViewModel.isFavourite(placeId: dataForIndex.placeId) {
//                cell.addToFavouriteButton.isSelected = true
//            } else {
//                cell.addToFavouriteButton.isSelected = false
//            }
           return cell
        } else {
            return NearYouTableViewCell()
            
        }
        
    }
}
