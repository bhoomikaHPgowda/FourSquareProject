//
//  FilterViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 01/07/21.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var radius: UITextField!
    @IBOutlet weak var search: CustomSearchBar!
    @IBOutlet weak var nearYou: CustomSearchBar!
    @IBOutlet weak var features: UITableView!
    @IBOutlet weak var rupee: CustomControlSegment!
    @IBOutlet weak var sort: UISegmentedControl!
    @IBOutlet weak var sortBy: CustomControlSegment!
    let featuresList: [String] = FeaturesList.allCases.map { $0.rawValue }
    var cityName = ""
    let filterDetail = FilterDetail(popular: false, distance: false, rating: false, radius: 0, accessToCard: false, delivery: false, dogFriendly: false, inWalkingDistance: false, outdoorSeating: false, parking: false, wifi: false)
    override func viewDidLoad() {
        super.viewDidLoad()
//        let segAttributes: NSDictionary = [
//            NSAttributedString.Key.foregroundColor: UIColor.red,
//            NSAttributedString.Key.font: UIFont(name: "Avenir-MediumOblique", size: 20)!
//        ]
//        var subViewOfSegment: UIView = sort.subviews[0] as UIView
//        subViewOfSegment.tintColor = UIColor.blue
//        sort.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: UIControl.State.selected)
//        //sortBy.setTitleTextAttributes(segAttributes as! [NSAttributedString.Key : Any], for: .normal)
//        // Do any additional setup after loading the view.
//        let subViewOfSegment1: UIView = sort.subviews[1] as UIView
//                subViewOfSegment1.backgroundColor = UIColor.red
       // self.sort.setSegmentStyle()
        features.delegate = self
        features.dataSource = self
        sort.layer.borderWidth = 1
        sort.layer.borderColor = UIColor.borderColorForSegmentControl().cgColor
        rupee.setTitle("\u{20B9}", forSegmentAt: 0)
        rupee.setTitle("\u{20B9} \u{20B9}", forSegmentAt: 1)
        rupee.setTitle("\u{20B9} \u{20B9} \u{20B9}", forSegmentAt: 2)
        rupee.setTitle("\u{20B9} \u{20B9} \u{20B9} \u{20B9}", forSegmentAt: 3)
        
        nearYou.setImage(UIImage(named: "map"), for: .search, state: .normal)
        search.setImage(UIImage(named: "searcgIcon"), for: .search, state: .normal)
        search.text = cityName
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            filterDetail.popular = true
            filterDetail.distance = false
            filterDetail.rating = false
        } else if sender.selectedSegmentIndex == 1 {
            filterDetail.popular = false
            filterDetail.distance = true
            filterDetail.rating = false
        }else {
            filterDetail.popular = false
            filterDetail.distance = false
            filterDetail.rating = true
        }
      
        
    }
    
    func optionSelected(option: String, value: Bool) {
        
        switch option {
        case FeaturesList.acceptsCreditCards.rawValue :
            filterDetail.accessToCard = value
            break
        case FeaturesList.delivery.rawValue:
            filterDetail.delivery = value
            break
        case FeaturesList.dogFreindly.rawValue:
            filterDetail.dogFriendly = value
            break
        case FeaturesList.inWalkingDistance.rawValue:
            filterDetail.inWalkingDistance = value
            break
        case FeaturesList.outdoorSearting.rawValue:
            filterDetail.outdoorSeating = value
            break
        case FeaturesList.parking.rawValue:
            filterDetail.parking = value
            break
        case FeaturesList.wifi.rawValue:
            filterDetail.wifi = value
        default:
            print("wrong option")
        }
    }

}
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FeaturesList.allCases.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FeaturesTableViewCell {
            
            cell.featureName.text = "\(featuresList[indexPath.row])"
            
            return cell
        } else {
            
            return FeaturesTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FeaturesTableViewCell
        print(cell.featureName.text)
        cell.featureName.textColor = UIColor.colorForSeletedFeatureLabel()
        cell.selectButton.toggle()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FeaturesTableViewCell
        print(cell.featureName.text)
        cell.featureName.textColor = UIColor.colorForNormalFeatureLabel()
        if let filterOption = cell.featureName.text {
            if cell.selectButton.isSelected {
                optionSelected(option: filterOption, value: true)
            } else {
                optionSelected(option: filterOption, value: false)
            }
            
        }
        
    }
}




//extension UISegmentedControl {
//func setSegmentStyle() {
// 
//
//    let normalTextAttributes: [NSAttributedString.Key : AnyObject] = [
//        NSAttributedString.Key.foregroundColor: UIColor.blue .withAlphaComponent(1.0),
//        NSAttributedString.Key.font: UIFont.normaTextForControlSegment()
//    ]
//
//     let segAttributes: [NSAttributedString.Key : AnyObject] = [
//        NSAttributedString.Key.foregroundColor: UIColor.gray,
//        NSAttributedString.Key.font:  UIFont.normaTextForControlSegment()
//        ]
//
//    setTitleTextAttributes(segAttributes, for: UIControl.State.selected)
//    }
//
//    // create a 1x1 image with this color
//    private func imageWithColor(color: UIColor) -> UIImage {
//        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//        context!.setFillColor(color.cgColor);
//        context!.fill(rect);
//        let image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return image!
//    }
//}
