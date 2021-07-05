//
//  AddReviewViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 02/07/21.
//

import UIKit

class AddReviewViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var select: UIButton!
    @IBOutlet weak var addReview: UITextView!
    @IBOutlet weak var imageview: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        addReview.delegate = self
        UITextView.addReviewTextViewSetUp(textView: addReview)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasDismissed(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

          if text == "\n" {
              textView.resignFirstResponder()
              return false
          }
          return true
      }
    
    @IBAction func selectImage(_ sender: UIButton) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
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
        
        submit.frame.origin.y = self.view.frame.height - submit.frame.height
    }

}

extension AddReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageview.image = image
            
        }
        select.frame.origin.x = 90
        dismiss(animated: true, completion: nil)
    }
    
    
}
