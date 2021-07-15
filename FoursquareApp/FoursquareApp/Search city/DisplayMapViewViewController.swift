//
//  DisplayMapViewViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 12/07/21.
//

import UIKit
import MapKit

class DisplayMapViewViewController: UIViewController {

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var restaurentImage: UIImageView!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var address: UILabel!
    var data = [PlaceDetail]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        detailView.isHidden = true
        // Do any additional setup after loading the view.
        placePins()
    }
    
    func setSelectedAnnotationValue(cityName: String) {
        detailView.isHidden = false
    
        for city in data {
            if city.placeName == cityName {
                placeName.text = city.placeName
                rating.text = "\(city.rating)"
                rating.backgroundColor = UIColor.ratingColor(rating: city.rating)
                address.text = city.address
                restaurentImage.image = UIImage.restaurentImage(url: city.imageUrl)
            }
        }
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func listView(_ sender: UIButton) {
    }
    
}
extension DisplayMapViewViewController: MKMapViewDelegate {
    
    func placePins() {
        for place  in data {
            let coords = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            let region = MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            mapView.setRegion(region, animated: true)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coords
            annotation.title = place.placeName
               mapView.addAnnotation(annotation)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation clicked\(view.annotation?.title)")
        
        guard let annotationName = view.annotation?.title as? String else {
            return
        }
        setSelectedAnnotationValue(cityName: annotationName)
    }
}
