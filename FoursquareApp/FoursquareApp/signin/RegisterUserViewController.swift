//
//  RegisterUserViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 06/07/21.
//

import UIKit

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var conformpasswordLabel: UILabel!
    @IBOutlet weak var confirmPassword: UITextField!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        mobileNumber.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        UILabel.addEmailLabel(label: emailLabel)
        UILabel.addphoneNumberLabel(label: mobileNumberLabel)
        UILabel.addPasswordLabel(label: passwordLabel)
        UILabel.addConformPasswordLabel(label: conformpasswordLabel)
    }
    

    @IBAction func SubmitTapped(_ sender: CustomButton) {
        
        guard let email = email.text,
              let mobileNumber = mobileNumber.text,
              let password = password.text,
              let confirmPassword = confirmPassword.text
        else {
            
            return
        }
        
        if password != confirmPassword {
            
            displayAlertMessage(title: AlertMessages.passwordMissmatch.rawValue,  Discription: AlertMessages.enterPassword.rawValue)
        } else {
            
            loginViewModel.registerUser(email: email, mobileNumber: mobileNumber, password: password, completionHandler: {
                statusCode
                in
                print("recived")
            })
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension RegisterUserViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (emailLabel.tag == 1 )  && (emailLabel.center.y == 190.0){
            
            emailLabel.center.y -= 20
        } else if (mobileNumberLabel.tag == 2) && (mobileNumberLabel.center.y == 265.0){
            
            mobileNumberLabel.center.y -= 20
        } else if (passwordLabel.tag == 3) && (passwordLabel.center.y == 335.0) {
            
            passwordLabel.center.y -= 20
        } else if(conformpasswordLabel.tag == 4) && (conformpasswordLabel.center.y == 405) {
            
            conformpasswordLabel.center.y -= 20
        }
    }
}
