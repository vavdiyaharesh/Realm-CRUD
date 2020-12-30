//
//  SelectDesignationView.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import Foundation
import UIKit

class SelectDesignationView: UIView {
    
    //MARK:- Outlets
    
    @IBOutlet weak var tblDesignation: UITableView!
    
    //MARK:- Setup UI

    func setAddEmployeeViewUI(theDelegate: SelectDesignationVC) {
        tblDesignation.tableFooterView = UIView()
        if theDelegate.designations.count == 0 {
            setupDesignnation(theDelegate: theDelegate)
        }else{
            theDelegate.designations.removeAll()
            setupDesignnation(theDelegate: theDelegate)
        }
    }
    func setupDesignnation(theDelegate: SelectDesignationVC){
        
        let defaultDesignation =
            ["CEO","HR","Designer","iOS Developer", "Android Developer", "Flutter Developer", "Backend Developer", "Unity Developer","Tester"]
        for designation in defaultDesignation {
            theDelegate.designations.append(designation)
        }
        tblDesignation.reloadData()
    }
    
}
