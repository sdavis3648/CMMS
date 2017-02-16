//
//  WorkOrderNumberSelectionDelegate.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/10/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit

protocol WorkOrderSelectionDelegate{
    func didSelectWorkOrderNumber(controller: UITableViewController, workOrderNumber: Int)
}
