//
//  WorkOrderModel.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/15/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import UIKit

class WorkOrderModel: NSObject {
    var workorderNumber = 0
    var workorderDescription = "Description"
    var workorderLocation = "Location"
    var workorderEnteredBy = "Entered By"
    var workorderEnteredDate = "Date"
    var workorderPriority = 1
    
    override init(){}
    init(workorderNumber:Int,
         workorderDescription:String,
         workorderLocation:String,
         workorderEnteredBy:String,
         workorderEnteredDate:String,
         workorderPriority:Int){
        self.workorderNumber = workorderNumber
        self.workorderDescription = workorderDescription
        self.workorderLocation = workorderLocation
        self.workorderEnteredBy = workorderEnteredBy
        self.workorderEnteredDate = workorderEnteredDate
        self.workorderPriority = workorderPriority
}
}
