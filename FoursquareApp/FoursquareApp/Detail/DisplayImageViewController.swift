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
    var userId = 0
    var titleName = ""
    var token = ""
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        print("token recieve ====\(token)")
        imageView.image = UIImage.restaurentImage(url: image)
        
        date.text = photoAddedDate
        
        placeName.text = titleName
        detailViewModel.fetchUserDetail(Id: userId, token: token, completionHandler: {
            userDetail
            in
            DispatchQueue.main.async {
                self.name.text = userDetail.userName
                self.profilePhoto.image = UIImage.restaurentImage(url: userDetail.imageUrl)

            }
                        
        })
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
