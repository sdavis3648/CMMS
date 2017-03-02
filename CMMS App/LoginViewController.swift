//
//  LoginViewController.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/18/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func submitButton(_ sender: UIButton) {
        let email = userIDTextField.text
        let password = passwordTextField.text
        FIRAuth.auth()?.signIn(withEmail: email!, password: password!) { (user, error) in
        }
        self.performSegue(withIdentifier: "UnwindToDashboard", sender: self)
    }


    override func viewDidLoad() {
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
