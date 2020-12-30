//
//  Realm_CRUDTests.swift
//  Realm-CRUDTests
//
//  Created by Vavdiya Haresh on 29/12/20.
//

import XCTest
@testable import Realm_CRUD
import RealmSwift

class Realm_CRUDTests: XCTestCase {

    var employees = [Employee]()
    
    override func setUp() {
      super.setUp()
     // Put setup code here.
    }

    override func tearDown() {
      // Put setup code here.
      super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    func testExample() throws {
        employees = getAllEmployee()
        let isFound = searchEmployeeInList(search_text: "Haresh")
        if isFound{
            editEmployeeData()
            deleteEmployee()
        }else{
            Swift.print("Search result is not found")
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getAllEmployee() -> [Employee]{
        let realm = try! Realm()
        var employees = [Employee]()
        let results = realm.objects(Employee.self).sorted { (e1, e2) -> Bool in
            return e1.empName.compare(e2.empName) == ComparisonResult.orderedAscending
        }
        employees = Array(results.map({ (e) -> Employee in
            return e
        }))
        if employees.count > 0{
            XCTAssertTrue((employees.count != 0), "Get the Employee list")
        }else{
            XCTAssertTrue((employees.count == 0), "No any employee added yet")
            addEmployee(id:employees.count+1,name:"Haresh Vavdiya",designasion:"CEO",age:"34")
        }
        return employees
    }
    
    func addEmployee(id:Int,name:String,designasion:String,age:String){
        let emp = Employee()
        emp.empID = id
        emp.empName = name
        emp.empDesignation = designasion
        emp.empAge = age
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(emp)
            }
            XCTAssertTrue(true, "Employee added sucessfuly")
        }catch {
            XCTFail("Employee adding error:-\(error.localizedDescription)")
        }
    }
    func searchEmployeeInList(search_text:String) -> Bool {
        let search_text = search_text // Search by name so enter name here
        let searchResults = self.employees.filter { (emp : Employee) -> Bool in
            return (emp.empName.lowercased().contains(search_text.lowercased()))
        }
        if searchResults.count == 0{
            XCTAssertEqual(0, searchResults.count, "Search employee not found")
            return false
        }else{
            Swift.print(searchResults)
            return true
        }
    }
    
    func editEmployeeData(){
        let realm = try! Realm()
        var emp = Employee()
        //emp.empID = 1 //If you know the id of the employee list then it's pass here
        emp.empName = "Haresh" // Enter here name of which value you want to editing
        let searchResults = self.employees.filter { (empl : Employee) -> Bool in
            //return (empl.empID == emp.empID) // if you have passed empID themn please un-comment this line and comment the below line
            return (empl.empName.lowercased().contains(emp.empName.lowercased()))
        }
        if searchResults.count != 0{
            let tempEmp  = searchResults.map({ (e) -> Employee in
                return e
            })
            do {
                emp = tempEmp.first ?? Employee()
                Swift.print(tempEmp)
                try realm.write {
                    emp.empID = tempEmp.first?.empID ?? 0
                    emp.empName = "Haresh Vavadiya" // Replaced name
                    emp.empDesignation = "Boss"
                    emp.empAge = "36"
                }
                XCTAssertTrue(true, "Employee edited sucessfuly")
                Swift.print(emp)
                Swift.print(realm.objects(Employee.self).first!)
                
            }catch {
                XCTFail("Employee editing error:-\(error.localizedDescription)")
            }
        }else{
            Swift.print("Record no found for editing")
        }
    }
    func deleteEmployee(){
        
        let emp = Employee()
        //emp.empID = 1 //If you know the id of the employee list then it's pass here
        emp.empName = "Haresh" // Enter name of which value you want to deleteing
        let searchResults = self.employees.filter { (empl : Employee) -> Bool in
            //return (empl.empID == emp.empID) // if you have passed empID themn please un-comment this line and comment the below line
            return (empl.empName.lowercased().contains(emp.empName.lowercased()))
        }
        if searchResults.count != 0{
            let tempEmp  = searchResults.map({ (e) -> Employee in
                return e
            })
            if tempEmp.count > 0{
                do {
                    let realm = try! Realm()
                    try realm.write {
                        realm.delete(tempEmp.first ?? emp)
                    }
                    XCTAssertTrue(true, "Employee deleted sucessfuly")
                }catch {
                    XCTFail("Employee deleting error:-\(error.localizedDescription)")
                }
            }else{
                Swift.print("Not Deleting")
            }
        }
    }

}
