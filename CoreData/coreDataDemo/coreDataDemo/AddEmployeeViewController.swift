//
//  AddEmployeeViewController.swift
//  coreDataDemo
//
//  Created by Animesh on 13.12.2025.
//

import UIKit

final class AddEmployeeViewController: UIViewController {

    // MARK: - UI Components

    private let profileImageView = ProfileImageView()

    private let nameTextField = RoundedTextField(
        placeholder: "Name"
    )

    private let emailTextField = RoundedTextField(
        placeholder: "Email",
        keyboardType: .emailAddress
    )

    private let addButton = PrimaryButton(
        title: "Add Employee"
    )

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
}
private extension AddEmployeeViewController {

    func setupUI() {
        title = "Add Employee"
        view.backgroundColor = .systemBackground

        navigationItem.largeTitleDisplayMode = .never

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(addButton)

        stackView.setCustomSpacing(24, after: profileImageView)
        stackView.setCustomSpacing(32, after: emailTextField)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        // Center profile image
        profileImageView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
    }
}
private extension AddEmployeeViewController {

    func setupActions() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(profileImageTapped)
        )
        profileImageView.addGestureRecognizer(tapGesture)

        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )
    }

    @objc
    func profileImageTapped() {
        print("Profile image tapped")
        // Image picker will be added in next step
    }

    @objc
    func addButtonTapped() {
        print("Add employee tapped")
        // Validation + ViewModel logic in later step
    }
}
