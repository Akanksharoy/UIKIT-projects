//
//  AddEditEmployeeViewModel.swift
//  coreDataDemo
//
//  Created by Akanksha on 18/12/25.
//
import UIKit

enum EmployeeFormMode {
    case add
    case edit(Employee)
}

protocol AddEditEmployeeViewModelProtocol {
    var name: String? { get }
    var email: String? { get }
    var profileImageData: Data? { get }

    func updateProfileImage(data: Data?)
    func save(name: String, email: String)
}

final class AddEditEmployeeViewModel: AddEditEmployeeViewModelProtocol {

    private let repository: EmployeeRepository
    private let mode: EmployeeFormMode

    private(set) var profileImageData: Data?

    init(
        mode: EmployeeFormMode,
        repository: EmployeeRepository
    ) {
        self.mode = mode
        self.repository = repository

        if case let .edit(employee) = mode {
            self.profileImageData = employee.profilePicture
        }
    }

    var name: String? {
        guard case let .edit(employee) = mode else { return nil }
        return employee.name
    }

    var email: String? {
        guard case let .edit(employee) = mode else { return nil }
        return employee.email
    }

    func updateProfileImage(data: Data?) {
        self.profileImageData = data
    }

    func save(name: String, email: String) {
        switch mode {
        case .add:
            let employee = Employee(
                name: name,
                email: email,
                profilePicture: profileImageData,
                id: UUID()
            )
            repository.create(employee: employee)

        case .edit(let employee):
            let updated = Employee(
                name: name,
                email: email,
                profilePicture: profileImageData,
                id: employee.id
            )
            repository.update(employee: updated)
        }
    }
}
