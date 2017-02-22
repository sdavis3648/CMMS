//
//  NewWorkOrderViewController.swift
//  CMMS App
//
//  Created by Spencer Davis on 2/2/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit
import Firebase

class NeWorkOrderViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    //MARK: Properties
    
    @IBOutlet weak var workOrderTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var prioritySelector: UISegmentedControl!
    
    override func viewDidLoad() {
        let ref = FIRDatabase.database().reference(withPath: "work-orders")
        //NEED TO DO THE QUERY LIMITED TO LAST HERE.....
        ref.child("WorkOrderNumber").observeSingleEvent(of: .value, with: { (snapshot) in
            let latestNumber = snapshot.value
            print(latestNumber)
        })
    
        /*
        ref.queryLimited(toLast: 1).observe(.value, with: { (snapshot) in
            let latestDescription = snapshot.value as? [String: AnyObject] ?? [:]
            print(latestDescription)
     })
     */
    
        //observe(.value, with: { (snapshot) in

        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: UITextFieldDelegate
    
    @IBAction func showPopUp(_ sender: Any) {
        //Save to Firebase
        let saveWorkOrder = DataService()
        let woNumber:Int? = Int(self.workOrderTextField.text!)
        let description = self.descriptionTextField.text
        let priority = self.prioritySelector.titleForSegment(at: prioritySelector.selectedSegmentIndex)
        saveWorkOrder.insertWorkOrder(woNumber: woNumber!,description: description!, priority: priority!)
        
        //Popup view controller
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "workorderCompletion") as! WorkOrderCompletedPopUpViewController
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
        
        
    }
    /*
    @IBAction func SaveWorkOrderButton(_ sender: Any) {
        let saveWorkOrder = DataService()
        let description = self.descriptionTextField.text
        let priority = self.prioritySelector.titleForSegment(at: prioritySelector.selectedSegmentIndex)
        saveWorkOrder.insertWorkOrder(description: description!, priority: priority!)
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        workOrderTextField.text = textField.text
        nameTextField.text = textField.text
        dateTextField.text = textField.text
        locationTextField.text = textField.text
        descriptionTextField.text = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        workOrderTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func prioritySegmentedButton(_ sender: UISegmentedControl) {
    }
    
    
}

