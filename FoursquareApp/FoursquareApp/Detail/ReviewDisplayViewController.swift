//
//  ReviewDisplayViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import UIKit

class ReviewDisplayViewController: UIViewController {
    
    var detailViewModel = DetailViewModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func getReview(){
        detailViewModel.getUsersReview()
    }
    
    
}

extension ReviewDisplayViewController:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewDisplayCell", for: indexPath) as? ReviewDisplayCell {
            cell.reviewerName.text = "Santhosh"
            cell.review.text = "Must try crab soup and  oyesters cookies with ghee!!"
            cell.reviewDate.text = "June 24,2014"
            return cell
        }
        return ReviewDisplayCell()
    }
    
    
}
