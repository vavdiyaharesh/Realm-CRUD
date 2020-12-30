//
//  EmployeeViewModel.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import Foundation
import RealmSwift

class EmployeeViewModel {
    
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
    
}
