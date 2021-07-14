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

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var favourite: UIButton!
    @IBOutlet weak var feedback: UIButton!
    @IBOutlet weak var aboutUs: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var profile: UIButton!
    var delegate: DismissSideMenu?
    var imagePicker = UIImagePickerController()
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: " ", email: " ", token: " ", userName: " ")
    var sideMenuViewModel = SideMenuViewModel()
    var imageaddress = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        profile.layer.cornerRadius = 0.5 * profile.bounds.size.width

        imagePicker.delegate = self
        username.text = userDetails.userName
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func addPhotos(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
        sideMenuViewModel.getphoto(userID: userDetails.id, token: userDetails.token, imageName: "/Users/bhoomikahp/Library/Developer/CoreSimulator/Devices/963050C7-AF98-4F83-B448-02B8FF01B2C8/data/Containers/Data/Application/3D3E978C-8A58-46C6-AFE1-E3EEDE052564/Documents/7D26D258-8276-45B4-9893-D839351468BE.jpeg", completionHandler:{
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
        print(imageName)
        print(imageURL)
        getImage(imgName: imageName!)
       
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            profile.setImage(img, for: .normal)
            profile.layer.cornerRadius = 42
            profile.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func getImage(imgName: String){
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths             = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath        = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(imgName)
            print(imageURL.path)
            imageaddress = imageURL.path
        }
        
    }
    
}


