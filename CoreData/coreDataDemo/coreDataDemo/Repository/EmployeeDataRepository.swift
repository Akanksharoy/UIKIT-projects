//
//  EmployeeDataRepository.swift
//  coreDataDemo
//
//  Created by Animesh on 13.09.2025.
//

import Foundation
import CoreData

protocol EmployeeRepository {
    func create(employee: Employee)
    func getAll() -> [Employee]?
    func get(id: UUID) -> Employee?
    func update(employee: Employee) -> Bool
    func delete(record: Employee) -> Bool
}

struct EmployeeDataRepository: EmployeeRepository {
    func create(employee: Employee) {
        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        cdEmployee.email = employee.email
        cdEmployee.id = employee.id
        cdEmployee.name = employee.name
        cdEmployee.profilePic = employee.profilePicture
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Employee]? {
        let result = PersistentStorage.shared.fetchedManagedObject(managedObject: CDEmployee.self)
        var employees: [Employee] = []
        result?.forEach{(cdEmployee) in
            employees.append(cdEmployee.convertToEmployee())
        }
        return employees
    }
    
    func get(id: UUID) -> Employee? {
        let result = getCDEmployee(id: id)
        guard result != nil else { return nil }
        return result?.convertToEmployee()
    }
    
    func update(employee: Employee) -> Bool{
        let cdEmployee = getCDEmployee(id: employee.id)
        guard cdEmployee != nil else { return false }
        cdEmployee?.email = employee.email
        cdEmployee?.name = employee.name
        cdEmployee?.profilePic = employee.profilePicture
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(record: Employee) -> Bool {
        let cdEmployee = getCDEmployee(id: record.id)
        guard cdEmployee != nil else { return false }
        PersistentStorage.shared.context.delete(cdEmployee!)
        PersistentStorage.shared.saveContext()
        return true
    }
    private func getCDEmployee(id: UUID) -> CDEmployee? {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil }
            return result
        }
        catch let error {
            debugPrint("Could not fetch. \(error)")
        }
        return nil
    }
    
}
