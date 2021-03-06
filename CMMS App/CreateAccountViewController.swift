//
//  CreateAccountViewController.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/18/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class CreateAccountViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordverifyTextField: UITextField!
    
    
    @IBAction func submitButton(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!,
                                   password: passwordTextField.text!)
        {(user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("user signed in!")
                user?.sendEmailVerification()
            }
        }
    }
    
    
    // For pressing return on the keyboard to dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
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
