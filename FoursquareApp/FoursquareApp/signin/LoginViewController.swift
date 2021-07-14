//
//  LoginViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var orButton: UIButton!
    var loginViewModel = LoginViewModel()

    @IBOutlet weak var passwordLabelTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        orButton.layer.cornerRadius = 0.5 * orButton.bounds.size.width
        email.delegate = self
        password.delegate = self
   
    }
    @IBOutlet weak var emailTopConstraint: NSLayoutConstraint!
    
    @IBAction func login(_ sender: CustomButton) {
        
        guard let email = email.text,
              let password = password.text
        else {
            
            return
        }
        
        print("username == \(email) password== \(password)")
        loginViewModel.authenticatUser(email: email, password: password, completionHandler: {
            
            detail
            
            in
            print("data recived ")
            print("\(detail.statusCode)")
            DispatchQueue.main.async {
                
                if detail.statusCode == 200 {
                    print("200000000000")
                    let homePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                    homePageViewController.userDetails = detail
                    self.navigationController?.pushViewController(homePageViewController, animated: true)
                } else if detail.statusCode == 401  {
                    
                    self.displayAlertMessage(title: AlertMessages.mailNotExist.rawValue,  Discription: AlertMessages.mailNotExist.rawValue)
                } else {
                    
                    self.displayAlertMessage(title: AlertMessages.wrongPassword.rawValue,  Discription: AlertMessages.wrongPassword.rawValue)
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = segue.destination as? ForgotPasswordViewController {
            temp.email = email.text ?? "nil"
            
        }
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 && emailTopConstraint.constant != 45 {
            emailTopConstraint.constant = emailTopConstraint.constant - 25
        } else if passwordLabelTopConstraint.constant != 20 {
            passwordLabelTopConstraint.constant = passwordLabelTopConstraint.constant - 18
        }
        
    }
    
    
}
