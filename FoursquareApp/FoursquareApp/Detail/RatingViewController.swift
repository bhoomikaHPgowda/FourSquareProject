//
//  RatingViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 04/07/21.
//

import UIKit

class RatingViewController: UIViewController {

    @IBOutlet var stars: [UIButton]!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var overAllRating: UILabel!
    @IBOutlet weak var cancel: UIButton!
    
    var rating = 0.0
    var placeId = 0
    var userEnteredRating: Int?
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: " ", email: " ", token: " ", userName: " ")
    var detailViewModel  = DetailViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        cancel.layer.cornerRadius = 11
        cancel.clipsToBounds = true
        overAllRating.text = "\(round(rating / 2))"
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor.lightGray.cgColor
        ratingView.layer.borderWidth = 1
        ratingView.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if let ratings = userEnteredRating {
            print("user entered ratings==\(ratings)")
            print("user entered token == \(userDetails.token)")
            print("\(placeId)")
            detailViewModel.addRating(userId: userDetails.id, token: userDetails.token, placeId: placeId, rating: ratings, completionHandler: {
                statuscode
                in
                print("statuscode =======\(statuscode)")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
               
            })
            
        }
    }
    
    @IBAction func starClicked(_ sender: UIButton) {
        
        print(sender.tag)
        updateButtonColor(range: sender.tag)
        userEnteredRating = sender.tag
    }
    
    func updateButtonColor(range: Int) {
        
        if range == 5 {
            
            for i in 1 ... 5 {
                stars[i-1].setImage(UIImage(named: "startSelected"), for: .normal)
            }
        } else {
            for i in 1 ... range {
                stars[i-1].setImage(UIImage.starButtonTappedImage(), for: .normal)
            }
            for i in range + 1 ... 5 {
                stars[i-1].setImage(UIImage.starButtonNotSeletced(), for: .normal)
            }
        }
    }
}
