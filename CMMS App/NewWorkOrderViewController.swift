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
import MobileCoreServices

class NewWorkOrderViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    var localPath: URL!
    var newImage: Bool?
    
    @IBOutlet weak var workOrderTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var prioritySelector: UISegmentedControl!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var photoAlbumImageView: UIImageView!
    
    // For pressing return on the keyboard to dismiss keyboard
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        nameTextField.text = FIRAuth.auth()?.currentUser?.email
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
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
        
        //Save tk Firebase Storage
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("WorkOrderPhotos/\(imageName).jpg")
        
        if let uploadData = UIImageJPEGRepresentation(self.photoImageView.image!, 1.0) {
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
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
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        self.dismiss(animated: true, completion: nil)
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            photoImageView.image = image
            if (newImage == true) {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(NewWorkOrderViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeImage as String) {
                // Code to support video here
            }
        }
    }

    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func selectImageFromCamera(_ sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
            newImage = true
        }
    }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
            newImage = false
        }
    }
    
    //MARK:Actions
    
    
    @IBAction func prioritySegmentedButton(_ sender: UISegmentedControl) {
    }
    
    
}

