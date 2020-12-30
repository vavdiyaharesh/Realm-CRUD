//
//  SelectDesignationVC.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import UIKit
import RealmSwift

class SelectDesignationVC: UIViewController {
    
    // MARK: - Variables And Properties
     lazy var mainView:SelectDesignationView = { [unowned self] in
         return self.view as! SelectDesignationView
         }()
    
    var designations = [String]()
    var selectedDesignation: String!
    var selectedhandler:(String) -> Void = { _ in }
    
    // MARK: - View Controller
    override func viewDidLoad() {
      super.viewDidLoad()
        self.mainView.setAddEmployeeViewUI(theDelegate: self)
    }
}
  // MARK: - Table View Data Source
extension SelectDesignationVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DesignationCell", for: indexPath)
        let designation = designations[indexPath.row]
        cell.textLabel?.text = designation
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return designations.count
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDesignation = designations[indexPath.row]
        selectedhandler(selectedDesignation)
        self.dismiss(animated: true, completion: nil)
    }
}
