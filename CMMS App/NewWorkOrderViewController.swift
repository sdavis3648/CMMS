//
//  NewWorkOrderViewController.swift
//  CMMS App
//
//  Created by Spencer Davis on 2/2/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class NewWorkOrderViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    private var localPath: URL!
    
    @IBOutlet weak var workOrderTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var prioritySelector: UISegmentedControl!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var photoAlbumImageView: UIImageView!
    
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
        
        
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("WorkOrderPhotos/\(imageName).jpg")
        
        if let uploadData = UIImageJPEGRepresentation(self.photoImageView.image!, 1.0) {
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                }
                let photoURL = metadata?.downloadURL()?.absoluteString
                saveWorkOrder.insertWorkOrder(woNumber: woNumber!,description: description!, priority: priority!, photoURL: photoURL!)
            })
            
        }

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
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageUrl          = info[UIImagePickerControllerReferenceURL] as? NSURL
        let imageName         = imageUrl?.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL          = NSURL(fileURLWithPath: documentDirectory)
        let localPath         = photoURL.appendingPathComponent(imageName!)
        
        if !FileManager.default.fileExists(atPath: localPath!.path) {
            do {
                try UIImageJPEGRepresentation(image, 1.0)?.write(to: localPath!)
                print("file saved")
            }catch {
                print("error saving file")
            }
        }
        else {
            print("file already exists")
        }

    }
    
    @IBAction func selectImageFromCamera(_ sender: UITapGestureRecognizer) {
        
        workOrderTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        workOrderTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK:Actions
    
    
    @IBAction func prioritySegmentedButton(_ sender: UISegmentedControl) {
    }
    
    
}

