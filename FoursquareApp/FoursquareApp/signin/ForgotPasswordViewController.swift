//
//  ForgotPasswordViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    var loginViewModel = LoginViewModel()
    var email = " "
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var OTP: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        OTP.delegate = self
        emailLabel.frame = CGRect(x: 145, y: 318, width: 85, height: 25)
        print(emailLabel.center.y)
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(emailLabel.center.y == 330.5){
            emailLabel.center.y -= 30
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (OTP.text == "1234"){
            if let temp = segue.destination as? ChangePasswordViewController {
                if let otpValue = Int(OTP.text ?? " "){
                    
                    temp.emailID = email
                }
               
            }
            
        }else{
            displayAlertMessage(title: AlertMessages.optImproper.rawValue, Discription: AlertMessages.properOTP.rawValue)
        }
       
    }
    
}
