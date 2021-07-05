//
//  ViewController.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 250))
        view.backgroundColor = .white

        let segmentedControl = UISegmentedControl()
        // Add segments
        segmentedControl.insertSegment(withTitle: "One", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Two", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Three", at: 2, animated: true)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.selected)
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.normal)
        // First segment is selected by default
        segmentedControl.selectedSegmentIndex = 0

        // This needs to be false since we are using auto layout constraints
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        // Add the segmented control to the container view
        view1.addSubview(segmentedControl)
        view.addSubview(view1)
        // Constrain the segmented control to the top of the container view
        segmentedControl.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        // Constrain the segmented control width to be equal to the container view width
        segmentedControl.widthAnchor.constraint(equalTo: view1.widthAnchor).isActive = true
        // Constraining the height of the segmented control to an arbitrarily chosen value
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true

        

        
    }


}

