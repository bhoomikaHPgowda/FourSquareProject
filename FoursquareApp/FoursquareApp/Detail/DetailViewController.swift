//
//  DetailViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 03/07/21.
//



import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var removeRatingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
       // gradientView.isHidden = true
        //ratingView.isHidden = true
        setCircularShapeForButton()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ratingImageClicked(_ sender: UIButton) {
        displayRatingView()
    }
    
    @IBAction func ratingButtonClicked(_ sender: UIButton) {
        displayRatingView()
    }
   
    @IBAction func removeRatingView(_ sender: UIButton) {
        hideRatingView()
    }
    
    @IBAction func submitButtonClicked(_ sender: CustomSubmitButton) {
        hideRatingView()
        
    }
    
    func setCircularShapeForButton(){
       // removeRatingButton.layer.cornerRadius = 0.5 * removeRatingButton.bounds.size.width
      //  removeRatingButton.clipsToBounds = true
      //  removeRatingButton.layer.borderWidth = 1
     //   removeRatingButton.layer.borderColor = UIColor.gray.cgColor
     //   removeRatingButton.clipsToBounds = true
        
    }
   
    func displayRatingView(){
     //   gradientView.isHidden = false
      // ratingView.isHidden = false
    }
    
    func hideRatingView(){
      //  gradientView.isHidden = true
     //  ratingView.isHidden = true
        
    }
    
   
    
}
