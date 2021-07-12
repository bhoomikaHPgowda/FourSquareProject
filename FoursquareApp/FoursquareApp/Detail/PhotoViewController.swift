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
    var photoFor = ""
    var pageNumber = 0
    var pageSizeValue = 10
    var placeDetail: PlaceDetail?
    var photos = [String]()
    var dates = [String]()
    var userId = [Int]()
    var index : Int?
    var userDetails = UserDetail(statuscode: 0, message: " ", id: 0, imageUrl: "https://aws-foursquare.s3.us-east-2.amazonaws.com/UserImage/10_photos.png", email: " ", token: " ", userName: "bhoomika")
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var placeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        imagePicker.delegate = self
        uploadPhotos()
        placeName.text = photoFor
        print("\(placeIdNum) iss  gghjgjhg")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPhotos(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func uploadPhotos() {
        detailViewModel.getHotelPhotosForCollectionView(placeID: placeIdNum, pageNo: pageNumber, pageSize: pageSizeValue, complitionHandler: {
            statusCode,images,dates, userIds
            in
            self.photos = images
            self.dates = dates
            self.userId = userIds
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
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        let vc = storyboard?.instantiateViewController(withIdentifier: "displayPhoto") as? DisplayImageViewController
        vc?.image = photos[indexPath.row]
        print(dates[indexPath.row])
        vc?.photoAddedDate = dates[indexPath.row]
        print(userDetails.userName)
        print(userDetails.imageUrl)
        vc?.titleName = photoFor
        vc?.uploaderName = userDetails.userName
        vc?.userId = userId[indexPath.row]
        vc?.profileImage = "https://aws-foursquare.s3.us-east-2.amazonaws.com/UserImage/10_photos.png"
        print("image== \(userDetails.imageUrl)")
        self.navigationController?.pushViewController(vc!, animated: true)
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

