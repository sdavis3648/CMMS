//
//  DashboardViewController.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/7/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginSubmit(segue:UIStoryboardSegue){
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {
                let firebaseauth = FIRAuth.auth()
            do {
                try firebaseauth?.signOut()
                print("should be signed out")
            } catch let signOutError as NSError {
                print ("Error signing out : %@", signOutError)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            // Check if user is logged in & change label text based on result
            let user = FIRAuth.auth()?.currentUser
            let email = user?.email
            
            if user != nil {
                self.loginButton.setTitle("Log Out", for: .normal)
                self.welcomeLabel.text = "Logged in as: \(email!)"
            } else {
                self.loginButton.setTitle("Log In", for: .normal)
                self.welcomeLabel.text = "Not currently logged in"
            }
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
