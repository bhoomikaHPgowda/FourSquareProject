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
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: " ", email: " ", token: " ")
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
            detailViewModel.addOrDeleteFavourite(userId: userDetails.id, token: userDetails.token, placeId: placeDetail[sender.tag].placeId, requestMethod: .addToFavourite, completionHandler: {
                statusCode
                in
                print("added succefully\(statusCode)")
            })
        } else {
            
            detailViewModel.addOrDeleteFavourite(userId: userDetails.id, token: userDetails.token, placeId: placeDetail[sender.tag].placeId, requestMethod: .deleteFromFavourite, completionHandler: {
                statusCode
                in
                print("added succefully\(statusCode)")
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
                return NearYouTableViewCell()
            }
            let dataForIndex = data[indexPath.row]
            cell.name.text = dataForIndex.placeName
            cell.rating.text = "\(round(dataForIndex.rating))"
            cell.detail.text = "\(dataForIndex.placeType.components(separatedBy:" ")[0]) " + " \u{2022} " + String(repeating: "\u{20B9}", count: dataForIndex.cost) + " \(round(dataForIndex.distance))Km"


            cell.address.text = dataForIndex.address
            cell.placeImage.image = detailViewModel.fetchImageForGivenPlace(url: dataForIndex.imageUrl)
            cell.layer.borderColor = UIColor.colorFoeCellSpace().cgColor
            cell.address.textColor = .darkGray
            cell.detail.textColor = .darkGray
            cell.layer.borderWidth = 3
            cell.addToFavouriteButton.tag = indexPath.row
            return cell
        } else {
            return NearYouTableViewCell()
            
        }
        
    }
    
    
    
}
