//
//  AddEmployeeVC.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import UIKit

class AddEmployeeVC: UIViewController {

    //MARK: - Variable
     lazy var mainView:AddEmployeeView = { [unowned self] in
         return self.view as! AddEmployeeView
         }()
     
     lazy var mainModelView: AddEmployeeViewModel = {
         return AddEmployeeViewModel()
     }()
    var selectedDesignation:String!
    var employeeID = Int()
    var employee: Employee!
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
        if let employee = employee {
          title = "Edit \(employee.empName)"
          mainView.fillTextFields(theDelegate: self)
        } else {
          title = "Add New Employee"
        }
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //MARK:- Button Action
    @IBAction func btnSaveAction(_ sender:UIButton){
        if mainModelView.validateFields(theDelegate: self) {
            if employee != nil {
                mainModelView.updateEmployee(theDelegate: self)
            } else {
                mainModelView.addNewEmployee(theDelegate: self)
            }
        } else {
            print(" some text feil is empty")
        }
    }
}
extension AddEmployeeVC:UITextFieldDelegate{
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.mainView.txtEmpDesignation{
            textField.resignFirstResponder()
            let vc = self.storyboard?.instantiateViewController(identifier: "SelectDesignationVC") as! SelectDesignationVC
            vc.selectedhandler = {[weak self]  (selectedDesignation) in
                self?.selectedDesignation = selectedDesignation
                self?.mainView.txtEmpDesignation.text = selectedDesignation
            }
            self.present(vc, animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
