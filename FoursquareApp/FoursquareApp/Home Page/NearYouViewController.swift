//
//  NearYouViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//

import UIKit

import UIKit
import MapKit

class NearYouViewController: UIViewController {

    @IBOutlet weak var nearYouTableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var detailViewModel = FetchPlaceDetailViewModel()
    let locationManager = CLLocationManager()
    var details1: [PlaceDetail]?
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: " ", email: " ", token: " ", userName: " ")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        nearYouTableView.delegate = self
        nearYouTableView.dataSource = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        nearYouTableView.separatorStyle = .singleLine
        nearYouTableView.separatorInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        nearYouTableView.separatorColor = UIColor.green
        print("user -----------\(userDetails.email)")
//        detailViewModel.fetchDetails(optionType: .nearYour,complitionHandler: {
//            details
//            in
//            self.details1 = details
//            print("\(details.count)")
//            self.add()
//        })
    }
    override func viewWillAppear(_ animated: Bool) {
        nearYouTableView.reloadData()
    }
    
    func add(count: Int) {
       print("data is calledjhsfjhsdfjgsdfhjdsgfhdsjhfdsf\(count)-------------------")
       // print(details1?.count)
        DispatchQueue.main.async {
            self.nearYouTableView.reloadData()
        }
        
    }
    
    func loc(lat: Double) {
        print("location from home view controller\(lat)")
    }
    @IBAction func addToFavourite(_ sender: CustomAddToFavoriteButton) {
        
        if let addToFavoriteButton = sender as? CustomAddToFavoriteButton {
            
            addToFavoriteButton.toggle()
        }
        guard let placeDetail = details1 else {
            return
        }
        if sender.isSelected {
            detailViewModel.addOrDeleteFavourite(userId: userDetails.id, token: userDetails.token, placeId: placeDetail[sender.tag - 1].placeId, requestMethod: .addToFavourite, completionHandler: {
                statusCode
                in
                print("added succefully\(statusCode)")
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        self.detailViewModel.favouritePlaceList!.append(placeDetail[sender.tag - 1])
                    }
                    
                }
                
                
            })
        } else {
            
            detailViewModel.addOrDeleteFavourite(userId: userDetails.id, token: userDetails.token, placeId: placeDetail[sender.tag - 1].placeId, requestMethod: .deleteFromFavourite, completionHandler: {
                statusCode
                in
                print("added succefully\(statusCode)")
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        self.detailViewModel.favouritePlaceList!.remove(at: sender.tag - 1 )
                    }
                }
            })
            
        }
        
    }
    
    

}
extension NearYouViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
       
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.first != nil {
            print("location:: \(locations)")
        }
        
        if let location = locations.first {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                  let region = MKCoordinateRegion(center: location.coordinate, span: span)
                  mapView.setRegion(region, animated: true)
        }

    }

}

extension NearYouViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details1?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let data = details1 {
            
            let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            self.navigationController?.pushViewController(detailViewController, animated: true)
            if let data = details1 {
                detailViewController.userDetails = userDetails
                detailViewController.detail = data[indexPath.row]
            }
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NearYouTableViewCell {
            guard let data = details1
            else {
                print("initaill iti is filed")
                return NearYouTableViewCell()
            }
            let dataForIndex = data[indexPath.row]
            cell.name.text = dataForIndex.placeName
            cell.rating.text = "\(dataForIndex.rating.rounded(places: 1))"
            cell.rating.backgroundColor = UIColor.ratingColor(rating: dataForIndex.rating)
            cell.detail.text = "\(dataForIndex.placeType.components(separatedBy:" ")[0]) " + " \u{2022} " + String(repeating: "\u{20B9}", count: dataForIndex.cost) + " \(round(dataForIndex.distance))Km"


            cell.address.text = dataForIndex.address
            cell.placeImage.image = detailViewModel.fetchImageForGivenPlace(url: dataForIndex.imageUrl)
            cell.layer.borderColor = UIColor.colorFoeCellSpace().cgColor
            cell.address.textColor = .darkGray
            cell.detail.textColor = .darkGray
            cell.layer.borderWidth = 3
            cell.addToFavouriteButton.tag = indexPath.row + 1
            if detailViewModel.isFavourite(placeId: dataForIndex.placeId) {
                cell.addToFavouriteButton.isSelected = true
            } else {
                cell.addToFavouriteButton.isSelected = false
            }
            return cell
        } else {
            return NearYouTableViewCell()
            
        }
        
    }
    
    
    
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
