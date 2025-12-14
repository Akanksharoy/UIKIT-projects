//
//  AddEmployeeViewController.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.12.2025.
//

import UIKit

final class AddEmployeeViewController: UIViewController {

    private let contentView: AddEmployeeViewProtocol

    // MARK: - Initializer (Dependency Injection)
    init(contentView: AddEmployeeViewProtocol = AddEmployeeView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        bindActions()
    }
}

private extension AddEmployeeViewController {

    func setupNavigation() {
        title = "Add Employee"
        navigationItem.largeTitleDisplayMode = .never
    }

    func bindActions() {
        contentView.onProfileImageTap = { [weak self] in
            self?.presentImagePicker()
        }

        contentView.onAddButtonTap = { [weak self] in
            self?.addEmployee()
        }
    }

    func presentImagePicker() {
        print("Profile image tapped")
    }

    func addEmployee() {
        let name = contentView.nameText
        let email = contentView.emailText

        print("Add employee tapped")
        print("Name:", name ?? "")
        print("Email:", email ?? "")
    }
}
