//
//  NewWorkOrderViewController.swift
//  CMMS App
//
//  Created by Spencer Davis on 2/2/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit
import Firebase

class NewWorkOrderViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var workOrderTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var prioritySelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK: UITextFieldDelegate

    @IBAction func showPopUp(_ sender: Any) {
        //Save to Firebase Database
        let saveWorkOrder = DataService()
        let woNumber:Int? = Int(self.workOrderTextField.text!)
        let description = self.descriptionTextField.text
        let priority = self.prioritySelector.titleForSegment(at: prioritySelector.selectedSegmentIndex)
        saveWorkOrder.insertWorkOrder(woNumber: woNumber!,description: description!, priority: priority!)
        
        
        /* WORKING ON SAVING IMAGE TO STORAGE
        //Save image to Storage
        let storageRef = FIRStorage.storage().reference().child("WorkOrderPhotos")
        
        //let data = UIImageJPEGRepresentation(photoImageView.image!, 0.8)!
        let woNumber:Int? = Int(self.workOrderTextField.text!)
        let fileName = "\(woNumber).jpg"
        let imageRef = storageRef.child(fileName)
        let path = imageRef.fullPath
        let name = imageRef.name
        let images = imageRef.parent()

        
        
        let uploadTask = imageRef.putFile(photoURL as URL, metadata: nil) {metadata, error in
            if let error = error {
                print("Error with image upload")
            } else {
                let downloadURL = metadata!.downloadURL()
            }
        }
       
        */
        
        
        //Popup view controller
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "workorderCompletion") as! WorkOrderCompletedPopUpViewController
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
        
        
    }
    
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
        /* WORKING ON SAVING IMAGE TO STORAGE
        let imageUrl          = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imageName         = imageUrl.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL          = NSURL(fileURLWithPath: documentDirectory)
        let localPath         = photoURL.appendingPathComponent(imageName!)
        let image             = info[UIImagePickerControllerOriginalImage]as! UIImage
        let data              = UIImagePNGRepresentation(image)
        
        do
        {
            try data?.write(to: localPath!, options: Data.WritingOptions.atomic)
        }
        catch
        {
            // Catch exception here and act accordingly
        }
         */
 
 
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

