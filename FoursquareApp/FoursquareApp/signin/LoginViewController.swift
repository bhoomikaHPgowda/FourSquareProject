//
//  LoginViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var orButton: UIButton!
    var loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        orButton.layer.cornerRadius = 0.5 * orButton.bounds.size.width
        // Do any additional setup after loading the view.
    }
    
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
                    let homePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                    homePageViewController.userDetails = detail
                    self.navigationController?.pushViewController(homePageViewController, animated: true)
                } else {
                    
                    return
                }
            }
           
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = segue.destination as? ForgotPasswordViewController {
            temp.email = email.text ?? "nil"
            
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
