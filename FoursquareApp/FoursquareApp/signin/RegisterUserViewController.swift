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
              let password = password.text
        else {
            return
        }
        loginViewModel.registerUser(email: email, mobileNumber: mobileNumber, password: password, completionHandler: {
            ()
            in
            print("added succefully")
        })
        
    }


}
