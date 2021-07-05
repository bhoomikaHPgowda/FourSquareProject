//
//  SideMenuViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 30/06/21.
//

import UIKit
class SideMenuViewController: UIViewController {

    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var buttonView: UIStackView!
    @IBOutlet weak var ABC: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newView = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width-100, height: self.view.frame.height))
        newView.backgroundColor = .white
        let newView1 = UIView(frame: CGRect(x: self.view.frame.width-100, y: 0, width: 100, height: self.view.frame.height))
        var signInVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NearYouViewController") as! NearYouViewController
        newView1.addSubview(signInVc.view)
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(newView)
        self.view.addSubview(newView1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)

        
        }
    

        @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
            
            dismiss(animated: true, completion: nil)
        }
    
    
}
