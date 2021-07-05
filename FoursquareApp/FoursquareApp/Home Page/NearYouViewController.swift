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
    let locationManager = CLLocationManager()
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
            print("location:: (location)")
        }
        
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                  let region = MKCoordinateRegion(center: location.coordinate, span: span)
                  mapView.setRegion(region, animated: true)
        }

    }

}

extension NearYouViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NearYouTableViewCell {
            cell.dcsd.text = "sushanth"
            cell.layer.borderColor = UIColor.colorFoeCellSpace().cgColor
               cell.layer.borderWidth = 3
            return cell
        } else {
            return NearYouTableViewCell()
            
        }
        
    }
    
    
    
}
