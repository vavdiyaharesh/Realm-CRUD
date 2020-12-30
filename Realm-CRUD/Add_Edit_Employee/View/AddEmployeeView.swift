//
//  AddEmployeeView.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import Foundation
import UIKit

class AddEmployeeView: UIView {
    
    //MARK:- Outlets
    
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var txtEmpDesignation: UITextField!
    @IBOutlet weak var txtEmpAge: UITextField!
    
    //MARK:- Setup UI
    func fillTextFields(theDelegate: AddEmployeeVC) {
        txtEmpName.text = theDelegate.employee.empName
        txtEmpDesignation.text = theDelegate.employee.empDesignation
        txtEmpAge.text = theDelegate.employee.empAge
        theDelegate.selectedDesignation = theDelegate.employee.empDesignation
    }
}
