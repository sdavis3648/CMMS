//
//  ViewController.swift
//  CMMS App
//
//  Created by Spencer Davis on 2/2/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var workOrderTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priorityValueButtons: UISegmentedControl!
    
    //MARK: Actions
    @IBAction func dateTextField(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

