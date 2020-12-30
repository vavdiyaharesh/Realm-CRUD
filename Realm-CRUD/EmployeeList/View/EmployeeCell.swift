//
//  EmployeeCell.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var lblEmpName: UILabel!
    @IBOutlet weak var lblEmpDesignation: UILabel!    
    @IBOutlet weak var lblAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configureCell(emp:Employee){
        lblEmpName.text! = emp.empName
        lblEmpDesignation.text! = emp.empDesignation
        lblAge.text! = emp.empAge
    }
}
