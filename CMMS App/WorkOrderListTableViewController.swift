//
//  WorkOrderListTableViewController.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/7/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit
import Firebase


class WorkOrderListTableViewController: UITableViewController {
    var workordersArray = [FIRDataSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ref = FIRDatabase.database().reference(withPath: "work-orders")
        ref.observe(.value, with: { snapshot in
            var newWorkOrders = [FIRDataSnapshot]()
            for workorder in snapshot.children {
                newWorkOrders.append(workorder as! FIRDataSnapshot)
            }
            
            self.workordersArray = newWorkOrders
            self.tableView.reloadData()
        })

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkOrderSelectionSegue",
            let destination = segue.destination as? WorkOrderViewController,
            let rowIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.selectedRow = rowIndex
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workordersArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let workOrder = workordersArray[indexPath.row]
        let workOrderDescription = workOrder.childSnapshot(forPath: "Description").value as! String
        cell.textLabel?.text = workOrderDescription
        return cell
    }


}
