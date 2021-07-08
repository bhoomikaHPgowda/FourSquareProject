//
//  ChangePasswordViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 05/07/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    var OTP = 0
    var emailID = " "
    var loginViewModel = LoginViewModel()

    @IBOutlet weak var conformPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
 
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePasswordSubmit(_ sender: Any) {
        
        guard let password = password.text,
              let conformPasword = conformPassword.text
        else {
            return
        }
        if (password == conformPasword) && (OTP == 1234) {
            
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
        }else{
        
            displayAlertMessage(title: AlertMessages.passwordMissmatch.rawValue,  Discription: AlertMessages.enterPassword.rawValue)
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
