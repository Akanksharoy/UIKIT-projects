//
//  ViewController.swift
//  coreDataDemo
//
//  Created by Animesh on 10.09.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //createEmployee()
//        fetchEmployee()
        // Do any additional setup after loading the view.
    }
    
//    func createEmployee() {
//        let employee = Employee(context: PersistentStorage.shared.context)
//        employee.name = "Animesh"
//        PersistentStorage.shared.saveContext()
//    }
//    
//    func fetchEmployee() {
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        debugPrint(path[0])
//        do {
//            guard let employees = try PersistentStorage.shared.context.fetch(Employee.fetchRequest()) as? [Employee] else {
//                return
//            }
//            employees.forEach({debugPrint($0.name)})
//        } catch {
//            print("Error fetching data: \(error)")
//        }
//    }


}

