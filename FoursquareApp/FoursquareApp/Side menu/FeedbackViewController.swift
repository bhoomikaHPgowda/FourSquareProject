//
//  FeedbackViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 30/06/21.
//

import UIKit

class FeedbackViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var feedback: UITextView!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasDismissed(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        feedback.delegate = self
        feedback.layer.cornerRadius = 5
        feedback.layer.borderWidth = 1
        feedback.layer.borderColor = UIColor.gray.cgColor
        feedback.clipsToBounds = true
        
       
    }
    @objc func keyboardNotification(notification: NSNotification) {
        print("key board showed")
        //topConstraints.constant = 80
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
            submit.frame.origin.y = keyboardHeight + 80
            }
        
    }
    
    @objc func keyboardWasDismissed(notification: NSNotification) {
        submit.frame.origin.y = mainView.frame.height - 60
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

          if text == "\n" {
              textView.resignFirstResponder()
              return false
          }
          return true
      }
    func keyboardWillShowNotification() {
        topConstraints.constant = 80
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
