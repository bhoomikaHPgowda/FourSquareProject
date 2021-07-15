//
//  ChangePasswordViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 05/07/21.
//

import UIKit

class ChangePasswordViewController: UIViewController , UITextFieldDelegate{
    
    var emailID = " "
    var loginViewModel = LoginViewModel()

    @IBOutlet weak var conformPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var conformPasswordLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        conformPassword.delegate = self
        password.delegate = self
        passwordLabel.frame = CGRect(x: 130, y: 190, width: 110, height: 21)
        conformPasswordLabel.frame = CGRect(x: 120, y: 260, width: 130, height: 21)
    }
    
    @IBAction func changePasswordSubmit(_ sender: Any) {
        
        guard let password = password.text,
              let conformPasword = conformPassword.text
        else {
            
            return
        }
        
        if (password == conformPasword) {
            
            loginViewModel.changePassword(email: emailID, password: password, completionHandler: {
                statusCode
                in
                
                DispatchQueue.main.async {
                    if statusCode == 200 {
                        print("Update Password sucessfully")
                    }
                    
                    if statusCode == 204{
                        self.displayAlertMessage(title: AlertMessages.mailNotExist.rawValue,  Discription: AlertMessages.properMailid.rawValue)
                        print("enter proper email in login screen")
                    }
                    
                    let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
                    self.navigationController?.pushViewController(loginViewController, animated: true)
                }
            })
        } else{
        
            displayAlertMessage(title: AlertMessages.passwordMissmatch.rawValue,  Discription: AlertMessages.enterPassword.rawValue)
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(passwordLabel.center.y == 200.5) && (textField.tag == 1){
            
            passwordLabel.center.y -= 30
        }
        if(conformPasswordLabel.center.y == 270.5) && (textField.tag == 2){
            
            conformPasswordLabel.center.y -= 30
        }
    }
}
