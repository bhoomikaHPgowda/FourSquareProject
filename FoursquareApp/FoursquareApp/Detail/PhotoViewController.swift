//
//  PhotoViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import UIKit

class PhotoViewController: UIViewController {

    var photo = [UIImage]()
    var imagePicker = UIImagePickerController()
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addPhotos(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    

}

extension PhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            photo.append(img)
        
            collectionView.dataSource = self
            collectionView.delegate = self
            self.collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCells", for: indexPath) as? CollectionViewCell{
            
            //cell.Images.image = UIImage(named: photos[indexPath.row])
            cell.images.image = photo[indexPath.row]
            return cell
        }
        return CollectionViewCell()
    }
    
    
}
