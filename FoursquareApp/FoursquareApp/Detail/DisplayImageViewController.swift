//
//  DisplayImageViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 10/07/21.
//

import Foundation
import UIKit

class DisplayImageViewController: UIViewController{
    
    var detailViewModel = DetailViewModel()
    var image = " "
    var profileImage = " "
    var photoAddedDate : String?
    var uploaderName = ""
    var titleName = ""
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        imageView.image = UIImage.restaurentImage(url: image)
        profilePhoto.image = UIImage.restaurentImage(url: profileImage)
        date.text = photoAddedDate
        name.text = uploaderName
        placeName.text = titleName
        
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
