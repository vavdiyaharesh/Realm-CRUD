//
//  EmployeeView.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import Foundation
import UIKit

class EmployeeView: UIView {
    
    //MARK:- Outlets
    @IBOutlet weak var tblEmployee: UITableView!
    
    //MARK:- Setup UI
    func setEmployeeViewUI(theDelegate: EmployeeListVC) {
        tblEmployee.rowHeight = UITableView.automaticDimension
        tblEmployee.estimatedRowHeight = 75
    }
    func setNoDataInfoIfEmployeeNotExists(theDelegate:EmployeeListVC)
    {
        let noDataLabel : UILabel = UILabel()
        noDataLabel.frame = CGRect(x: 0, y: 0, width: tblEmployee.bounds.width, height: tblEmployee.bounds.height)
        noDataLabel.text = "No Records Found"
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        tblEmployee.backgroundView = noDataLabel
        tblEmployee.separatorStyle = .none
    }
}
