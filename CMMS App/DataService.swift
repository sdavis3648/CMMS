//
//  DataService.swift
//  CMMS App
//
//  Created by Harry Helmrich on 2/15/17.
//  Copyright © 2017 Spencer Davis. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let dataService = DataService()
    
    
    private var _BASE_REF : FIRDatabaseReference!
    private var _WORKORDER_REF : FIRDatabaseReference
    
    init(){
        self._BASE_REF = FIRDatabase.database().reference()
        self._WORKORDER_REF = self._BASE_REF.child("work-orders")
    }

    func insertWorkOrder(woNumber: Int, description: String, priority: String){
        let key = self._WORKORDER_REF.childByAutoId().key
        let workorder : NSDictionary = ["WorkOrderNumber" : woNumber,
                                        "Description" : description,
                                        "Priority" : priority]
        self._WORKORDER_REF.updateChildValues(["/\(key)" : workorder])
    }
    
}
