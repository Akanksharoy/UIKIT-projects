//
//  EmployeeListViewModel.swift
//  coreDataDemo
//
//  Created by Animesh on 14.09.2025.
//

import Foundation
import UIKit

protocol EmployeeListViewModelProtocol {
    var employees: [Employee] { get }
    
    func loadEmployees()
    func addEmployee(name: String?, email: String?, profilePicture: Data?)
    func updateEmployee(id: UUID, name: String?, email: String?, profilePicture: Data?) -> Bool
    func deleteEmployee(id: UUID) -> Bool
    
    // UI helpers (instead of EmployeeViewModel)
    func displayName(for employee: Employee) -> String
    func displayEmail(for employee: Employee) -> String
    func profileImage(for employee: Employee) -> UIImage?
}

final class EmployeeListViewModel: EmployeeListViewModelProtocol {
    private let repository: EmployeeRepository
    private(set) var employees: [Employee] = []
    
    init(repository: EmployeeRepository) {
        self.repository = repository
        loadEmployees()
    }
    
    func loadEmployees() {
        employees = repository.getAll() ?? []
    }
    
    func addEmployee(name: String?, email: String?, profilePicture: Data?) {
        let employee = Employee(
            name: name,
            email: email,
            profilePicture: profilePicture,
            id: UUID()
        )
        repository.create(employee: employee)
        loadEmployees()
    }
    
    func updateEmployee(id: UUID, name: String?, email: String?, profilePicture: Data?) -> Bool {
        let employee = Employee(
            name: name,
            email: email,
            profilePicture: profilePicture,
            id: id
        )
        let success = repository.update(employee: employee)
        if success { loadEmployees() }
        return success
    }
    
    func deleteEmployee(id: UUID) -> Bool {
        guard let employee = repository.get(id: id) else { return false }
        let success = repository.delete(record: employee)
        if success { loadEmployees() }
        return success
    }
    
    // MARK: - UI Helpers
    
    func displayName(for employee: Employee) -> String {
        employee.name ?? "No Name"
    }
    
    func displayEmail(for employee: Employee) -> String {
        employee.email ?? "No Email"
    }
    
    func profileImage(for employee: Employee) -> UIImage? {
        guard let data = employee.profilePicture else {
            return UIImage(systemName: "person.circle.fill")
        }
        return UIImage(data: data)
    }
}
