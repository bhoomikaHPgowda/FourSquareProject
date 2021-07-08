//
//  RatingViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 04/07/21.
//

import UIKit

class RatingViewController: UIViewController {

    @IBOutlet weak var overAllRating: UILabel!
    @IBOutlet weak var cancel: UIButton!
    var rating = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        cancel.layer.cornerRadius = 11
        cancel.clipsToBounds = true
        overAllRating.text = "\(rating)"
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
