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
    var detailViewModel = DetailViewModel()
    var placeIdNum = 0
    var pageNumber = 0
    var pageSizeValue = 10
    var photos = [String]()
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        imagePicker.delegate = self
        uploadPhotos()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addPhotos(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func uploadPhotos() {
        detailViewModel.getHotalPhotosForCollectionView(placeID: placeIdNum, pageNo: pageNumber, pageSize: pageSizeValue, complitionHandler: {
            statusCode,images
            in
            self.photos = images
            DispatchQueue.main.async {
                if statusCode == 200 {
                    print(self.photos)
                    print("Update Photos sucessfully")
                    self.collectionView.dataSource = self
                    self.collectionView.delegate = self
                    self.collectionView.reloadData()

                }
            }
        })
    }
    
    func callCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.reloadData()
    }
    

}

extension PhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            photo.append(img)
            callCollectionView()
        
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageSizeValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCells", for: indexPath) as? CollectionViewCell{
            print(photos[indexPath.row])
           
            //cell.Images.image = UIImage(named: photos[indexPath.row])
            cell.images.image = UIImage.restaurentImage(url: photos[indexPath.row])
            cell.images.contentMode = UIView.ContentMode.scaleToFill
            return cell
        }
        return CollectionViewCell()
    }
    
    
}

