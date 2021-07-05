//
//  PopularViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//

import UIKit

class PopularViewController: UIViewController {
    var index: Int?
    var count = 10
    @IBOutlet weak var popularListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularListTableView.delegate = self
        popularListTableView.dataSource = self
    }
    func added() {
        if let index = index {
            count = index
           // popularListTableView.reloadData()
        }
        print(index)
       // popularListTableView.reloadData()
    }
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    func reloads() {
        popularListTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
      
            return 195
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PopularTableViewCell {
            if let index = index {
                cell.dcsd.text = "\(index)"
            }
           // cell.dcsd.text = "sushanth"
            cell.layer.borderColor = UIColor.colorFoeCellSpace().cgColor
               cell.layer.borderWidth = 3
            //reloads()
            return cell
        } else {
            
            return PopularTableViewCell()
        }
    }
}

