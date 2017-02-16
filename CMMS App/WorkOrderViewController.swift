//
//  WorkOrderViewController.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/7/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit

class WorkOrderViewController: UIViewController{
    var selectedRow:Int!
    
    @IBOutlet weak var workOrderNameText: UITextField!
    @IBOutlet weak var enteredByNameText: UITextField!
    @IBOutlet weak var enteredDateText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        self.workOrderNameText.text = workorderNumbers[selectedRow]
        self.enteredDateText.text = workorderDates[selectedRow]
        self.enteredByNameText.text = workorderNames[selectedRow]
        self.descriptionText.text = workorderDescriptions[selectedRow]
        self.locationText.text = workorderLocations[selectedRow]
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
