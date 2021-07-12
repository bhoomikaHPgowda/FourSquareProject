//
//  ReviewDisplayViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import UIKit

class ReviewDisplayViewController: UIViewController {
    
    var detailViewModel = DetailViewModel()
    var placeIdNum = 10
    var pageNumber = 0
    var pageSizeValue = 8
    var reviewedPlace = ""
    var reviewersNames = [String]()
    var reviewDates = [String]()
    var reviewersReview = [String]()
    var reviewersImages = [String]()
    var placeDetail: PlaceDetail?
    var userDetails: UserDetail?
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        placeName.text = reviewedPlace
        getReview()
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let temp = segue.destination as? AddReviewViewController{
                temp.userDetails = userDetails
                temp.placeDetail = placeDetail
            }
        }
       
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func getReview(){
        detailViewModel.getUsersReview(placeID: placeIdNum, pageNo: pageNumber, pageSize: pageSizeValue, complitionHandler: {
            data
            in
            self.reviewersNames = data.name
            self.reviewDates = data.dates
            self.reviewersReview = data.reviews
            self.reviewersImages = data.profileImage

            DispatchQueue.main.async{
                if(data.statusCode == 200){
                    print("update")
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                }
            }
        })
    }
    
}

extension ReviewDisplayViewController:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reviewersNames.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewDisplayCell", for: indexPath) as? ReviewDisplayCell {
            
            cell.reviewerName.text = reviewersNames[indexPath.row]
            cell.review.text = reviewersReview[indexPath.row]
            cell.reviewDate.text = reviewDates[indexPath.row]
            cell.reviewerPhoto.image = UIImage.restaurentImage(url: reviewersImages[indexPath.row])
               
            return cell
        }
        return ReviewDisplayCell()
    }
    
    
}
