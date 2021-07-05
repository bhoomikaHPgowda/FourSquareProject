//
//  SearchViewController.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var nearMe: CustomSearchBar!
//    @IBOutlet weak var search: CustomSearchBar!
//    @IBOutlet weak var nearPlace: UITextField!
//    @IBOutlet weak var searchPlace: UITextField!
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
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
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FeaturesList.allCases.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchedListTableViewCell {
            
            cell.cityName.text = "Udupi"
            cell.cityImage.image = UIImage(named: "1")
            
            return cell
        } else {
            
            return SearchedListTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SearchedListTableViewCell
        print(cell.cityName.text)
        cell.cityName.textColor = UIColor.colorForSeletedFeatureLabel()
        //cell.selectButton.toggle()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchedListTableViewCell
        print(cell.cityName.text)
        cell.cityName.textColor = UIColor.colorForNormalFeatureLabel()
    }
}
