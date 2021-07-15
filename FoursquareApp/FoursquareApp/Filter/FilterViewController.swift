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
    let filterDetail = FilterDetail(popular: false, distance: false, rating: false, radius: 0, cost: 0, accessToCard: false, delivery: false, dogFriendly: false, inWalkingDistance: false, outdoorSeating: false, parking: false, wifi: false)
    let viewModel = FilterViewModel()
    typealias completion = (([PlaceDetail]) -> ())
    var completionHandler: completion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func cost(_ sender: CustomControlSegment) {
        filterDetail.cost = sender.selectedSegmentIndex
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
    
    @IBAction func doneTapped(_ sender: UIButton) {
        
        viewModel.filterCityDetail(filterOption: filterDetail, landMark: cityName, completionHander: {
            filteredData
            in
            print(filteredData.count)
            DispatchQueue.main.async {
                guard let closure = self.completionHandler else {
                    return
                    
                }
                closure(filteredData)
            }
        })
        
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

extension FilterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let data = textField.text, let radius = Int(data) {
            print("ended")
            filterDetail.radius = radius
        } else {
            filterDetail.radius = 0

        }
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("ended")
        if let data = textField.text, let radius = Int(data) {
            filterDetail.radius = radius
        } else {
            filterDetail.radius = 0

        }
        return true
    }
}
