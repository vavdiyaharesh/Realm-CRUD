//
//  AddEmployeeViewModel.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import Foundation
import RealmSwift

class AddEmployeeViewModel {
    
    var employees = [Employee]()
    var searchResults = [Employee]()
    
    func loadEmployees(){
        let results = AppDelegate().realm.objects(Employee.self).sorted { (e1, e2) -> Bool in
            return e1.empName.compare(e2.empName) == ComparisonResult.orderedAscending
        }
        self.employees = Array(results.map({ (e) -> Employee in
            return e
        }))
    }
    
    // MARK: - validation Methods
    func validateFields(theDelegate:AddEmployeeVC) -> Bool {
      if
        theDelegate.mainView.txtEmpName.text!.isEmpty ||
            theDelegate.mainView.txtEmpAge.text!.isEmpty ||
            theDelegate.selectedDesignation == nil {
        theDelegate.alert(title: "Validation Error", message: "All fields must be filled")
        return false
      } else {
        return true
      }
    }
    // MARK: - Add NewEmployee Methods
    func addNewEmployee(theDelegate:AddEmployeeVC) {
        try! AppDelegate().realm.write {
        let newEmployee = Employee()
            newEmployee.empID = theDelegate.employeeID
            newEmployee.empName = theDelegate.mainView.txtEmpName.text!
            newEmployee.empDesignation = theDelegate.selectedDesignation
            newEmployee.empAge = theDelegate.mainView.txtEmpAge.text!
            print(newEmployee)
            AppDelegate().realm.add(newEmployee)
            
            theDelegate.alert(title: "Alert", message: "Employee \(theDelegate.mainView.txtEmpName.text ?? "") sucessfully added.")
            theDelegate.employee = newEmployee
            theDelegate.employeeID += 1
            theDelegate.mainView.txtEmpName.text = ""
            theDelegate.selectedDesignation = nil
            theDelegate.mainView.txtEmpDesignation.text = ""
            theDelegate.mainView.txtEmpAge.text = ""
      }
    }
    func updateEmployee(theDelegate:AddEmployeeVC) {
      try! AppDelegate().realm.write {
        theDelegate.employee.empID = theDelegate.employee.empID
        theDelegate.employee.empName = theDelegate.mainView.txtEmpName.text!
        theDelegate.employee.empDesignation = theDelegate.selectedDesignation
        theDelegate.employee.empAge = theDelegate.mainView.txtEmpAge.text!
      }
        theDelegate.alert(title: "Alert", message: "Employee \(theDelegate.mainView.txtEmpName.text ?? "") edited sucessfully.")
    }
    
}
