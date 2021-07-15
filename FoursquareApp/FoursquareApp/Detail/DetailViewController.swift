//
//  DetailViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 03/07/21.
//



import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var hotelDescription: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var fullAddress: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var restaurentImage: UIImageView!
    @IBOutlet var stars: [UIButton]!
   
    var detail:PlaceDetail?
    var id: Int?
    var placeID: Int?
    var detailViewModel = DetailViewModel()
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: " ", email: " ", token: " ", userName: " ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        mapview.delegate = self
        if let placeid = id {
            
            detailViewModel.fetchDetails(id: placeid, complitionHandler: {
                
                detailRecieved
                
                in
                self.placeID = detailRecieved.placeId
                DispatchQueue.main.async {
                    
                    print("detail === \(detailRecieved.cost)")
                    self.detail = detailRecieved
                    self.updateValuesReceived()
                }
            })
        }
       
        detailViewModel.fetchDetails(id: 16, complitionHandler: {
            
            details
            in
            print("details received from api")
            DispatchQueue.main.async {
                self.updateValuesReceived()
            }
        })
            
        self.updateValuesReceived()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let temp = segue.destination as? PhotoViewController {
            
            if let temp1 = placeID {
                
                temp.placeIdNum = temp1
                print("passed dat from okne to antohe \(temp)")
            }
        }
    }
    
    @IBAction func photos(_ sender: UIButton) {
        
        guard let place = detail else {
            
            print("no  recieved detail")
            return
        }
        let photoViewController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        print("this is id pases frim th pjtot\(place.placeId)")
        photoViewController.placeIdNum = place.placeId
        
        if let data = detail {
            
            photoViewController.photoFor = data.placeName
        }
        photoViewController.userDetails = userDetails
        print(userDetails.userName)
        navigationController?.pushViewController(photoViewController, animated: true)
    }
    
    @IBAction func review(_ sender: UIButton) {
        
        guard let place = detail else {
            print("no  recieved detail")
            return
        }
        let reviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "reviewDisplayViewController") as! ReviewDisplayViewController
        print("this is id pases frim th pjtot\(place.placeId)")
        reviewViewController.placeIdNum = place.placeId
        reviewViewController.placeDetail = place
        if let data = detail {
            
            reviewViewController.reviewedPlace = data.placeName
        }
        reviewViewController.userDetails = userDetails
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    func updateValuesReceived() {
        
        if let data = detail {
            
            name.text = data.placeName
            overview.text = data.overview
            address.text = data.address
            fullAddress.text = data.address
            mobileNumber.text = "+91 \(data.phone)"
            distance.text = "\(round(data.distance))Km"
            print("lat and lobg \(data.latitude) \(data.longitude)")
            let center = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            mapview.setRegion(region, animated: true)
            placePins(latitude: data.latitude, longitude: data.longitude, place: data.placeName)
            
            for i in 0 ..< Int(round(data.rating / 2)) {
                
                stars[i].setImage(UIImage(named: "startSelected"), for: .normal)
            }
            if let images = UIImage.restaurentImage(url: data.imageUrl) {
                
                restaurentImage.image = images
                restaurentImage.contentMode = .scaleAspectFill
            }
        }
    }
    
    func placePins(latitude: Double, longitude: Double, place: String ) {
        
        let coords = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coords
        annotation.title = place
        mapview.addAnnotation(annotation)
    }
    
   
    
    @IBAction func ratingButtonClicked(_ sender: UIButton) {
        
        let ratingViewController = self.storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        if let data = detail {
            
            ratingViewController.rating = data.rating
            ratingViewController.placeId = data.placeId
        }
        ratingViewController.userDetails = userDetails
        ratingViewController.modalPresentationStyle = .overFullScreen
        present(ratingViewController, animated: true, completion: nil)
    }
   
    @IBAction func back(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}
