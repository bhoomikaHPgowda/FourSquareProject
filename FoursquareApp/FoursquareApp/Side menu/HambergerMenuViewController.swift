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
    @IBOutlet weak var profile: UIButton!
    var delegate: DismissSideMenu?
    var imagePicker = UIImagePickerController()
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: " ", email: " ", token: " ")
    var sideMenuViewModel = SideMenuViewModel()
    var imageaddress = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        profile.layer.cornerRadius = 0.5 * profile.bounds.size.width

        imagePicker.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func addPhotos(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        sideMenuViewModel.getphoto(userID: userDetails.id, token: userDetails.token, imageName: imageaddress, completionHandler:{
            statusCode
            in
            print("data recived ")
            DispatchQueue.main.async {
                if statusCode == 200 {
                    print("profile pic Added sucessesfully")
                }
                
            }
            
        })
        
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

extension HambergerMenuViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
        let imageName = imageURL?.lastPathComponent
        imageaddress = imageName ?? "nil"
       print(imageName)
       // print(imageURL)
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            profile.setImage(img, for: .normal)
            profile.layer.cornerRadius = 42
            profile.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    
}

