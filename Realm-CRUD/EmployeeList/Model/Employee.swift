//
//  Employee.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import Foundation
import RealmSwift

class Employee: Object {
  @objc dynamic var empID = 0
  @objc dynamic var empName = ""
  @objc dynamic var empDesignation = ""
  @objc dynamic var empAge = ""
}

