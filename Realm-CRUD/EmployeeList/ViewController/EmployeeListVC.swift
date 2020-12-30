//
//  EmployeeListVC.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import UIKit
import Realm

class EmployeeListVC: UIViewController {

    //MARK: - Variable
    lazy var mainView:EmployeeView = { [unowned self] in
        return self.view as! EmployeeView
    }()
    lazy var mainModelView: EmployeeViewModel = {
        return EmployeeViewModel()
    }()
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        configureSearch()
        mainView.setEmployeeViewUI(theDelegate: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        mainModelView.loadEmployees()
        print(mainModelView.employees)
        mainView.tblEmployee.tableFooterView = UIView()
        mainView.tblEmployee.reloadData()
    }    
    //MARK:- Button Action
    @IBAction func btnAddEmployee(_ sender: Any) {
        let addEmployee = self.storyboard?.instantiateViewController(identifier: "AddEmployeeVC") as! AddEmployeeVC
        addEmployee.employeeID = mainModelView.employees.count+1
        self.navigationController?.pushViewController(addEmployee, animated: true)
    }
}
//MARK - TableView delegates Methods
extension EmployeeListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return mainModelView.searchResults.count
        }else {
            return mainModelView.employees.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") as! EmployeeCell
        let emp: Employee
        if isFiltering(){
            emp = mainModelView.searchResults[indexPath.row]
        }else {
            emp = mainModelView.employees[indexPath.row]
        }
        print(emp)
        cell.configureCell(emp: emp)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addEmployee = self.storyboard?.instantiateViewController(identifier: "AddEmployeeVC") as! AddEmployeeVC
        addEmployee.employeeID = mainModelView.employees.count+1
        addEmployee.employee = isFiltering() == true ? mainModelView.searchResults[indexPath.row] : mainModelView.employees[indexPath.row]
        self.navigationController?.pushViewController(addEmployee, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! AppDelegate().realm.write {
                AppDelegate().realm.delete(isFiltering() == true ? mainModelView.searchResults[indexPath.row] : mainModelView.employees[indexPath.row])
            }
            if isFiltering() == true { mainModelView.searchResults.remove(at: indexPath.row)}else{ mainModelView.employees.remove(at: indexPath.row)}
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK - search Delegates methods

extension EmployeeListVC: UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate {
    
    func isFiltering() -> Bool {
        return self.searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        self.mainModelView.searchResults = self.mainModelView.employees.filter({( post : Employee) -> Bool in
            return post.empName.lowercased().contains(searchText.lowercased())
        })
        self.mainView.tblEmployee.reloadData()
    }
    func configureSearch() {
        searchController.searchBar.placeholder = "Search by name"
        searchController.searchBar.barTintColor = UIColor.white
        searchController.delegate = self
        searchController.searchBar.delegate = self
        let searchBar = searchController.searchBar
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = .systemBlue
        }
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController!.searchBar.delegate = self
        self.navigationItem.searchController!.searchResultsUpdater = self
        self.navigationItem.searchController?.searchBar.showsCancelButton = true
    }
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
