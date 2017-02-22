//
//  WorkOrderCompletedPopUpViewController.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/16/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit

class WorkOrderCompletedPopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.8)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: UITapGestureRecognizer) {
        self.view.removeFromSuperview()
        _ = navigationController?.popViewController(animated: true)
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
