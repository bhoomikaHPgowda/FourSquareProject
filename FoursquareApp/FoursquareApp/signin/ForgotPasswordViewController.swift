//
//  ForgotPasswordViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    var loginViewModel = LoginViewModel()
    var email = " "
    @IBOutlet weak var OTP: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (OTP.text == "1234"){
            if let temp = segue.destination as? ChangePasswordViewController {
                if let otpValue = Int(OTP.text ?? " "){
                    temp.OTP = otpValue
                    temp.emailID = email
                }
               
            }
            
        }else{
            displayAlertMessage(title: AlertMessages.optImproper.rawValue, Discription: AlertMessages.properOTP.rawValue)
        }
       
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
