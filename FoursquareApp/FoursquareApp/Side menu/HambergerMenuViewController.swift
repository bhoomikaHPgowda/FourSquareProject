//
//  HambergerMenuViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 30/06/21.
//

import UIKit

protocol DismissSideMenu {
    func setConstraints()
    func sidemenuSelectedOption(option: SideMenuOption)
}

class HambergerMenuViewController: UIViewController {

    @IBOutlet weak var favourite: UIButton!
    @IBOutlet weak var feedback: UIButton!
    @IBOutlet weak var aboutUs: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var profile: UIImageView!
    var delegate: DismissSideMenu?
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        profile.layer.cornerRadius = 42
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        delegate?.setConstraints()
        view.window!.layer.add(CATransition.transitionRightToLeft(), forKey: kCATransition)
        dismiss(animated: true, completion: nil)
    }
    
    func operationToPerform(option: SideMenuOption) {
        view.window!.layer.add(CATransition.transitionRightToLeft(), forKey: kCATransition)
        delegate?.setConstraints()
        dismiss(animated: true, completion: {
        
            self.delegate?.sidemenuSelectedOption(option: option)
        })
    }
    
    @IBAction func favouriteTapped(_ sender: CustomButtonForSidemenu) {
        
        operationToPerform(option: .favourite)
    }
    
    @IBAction func logoutTapped(_ sender: CustomButtonForSidemenu) {
        
        operationToPerform(option: .logout)
    }
    
    @IBAction func aboutUsTapped(_ sender: CustomButtonForSidemenu) {
        
        operationToPerform(option: .aboutUs)
    }
    
    @IBAction func feedBackTapped(_ sender: CustomButtonForSidemenu) {
        
        operationToPerform(option: .feedback)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
