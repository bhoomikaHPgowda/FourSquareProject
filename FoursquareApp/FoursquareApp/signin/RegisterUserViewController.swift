//
//  RegisterUserViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 06/07/21.
//

import UIKit

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var loginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
