//
//  AddEmployeeView.swift
//  coreDataDemo
//
//  Created by Akanksha on 14.12.2025.
//

import UIKit

protocol AddEmployeeViewProtocol: UIView {
    
    // Inputs (VC → View)
    var nameText: String? { get set }
    var emailText: String? { get set }
    
    // Outputs (View → VC)
    var onProfileImageTap: (() -> Void)? { get set }
    var onAddButtonTap: (() -> Void)? { get set }
}

final class AddEmployeeView: UIView, AddEmployeeViewProtocol {
    
    // MARK: - UI Components
    
    let profileImageView = ProfileImageView()
    
    let nameTextField = RoundedTextField(
        placeholder: "Name"
    )
    
    let emailTextField = RoundedTextField(
        placeholder: "Email",
        keyboardType: .emailAddress
    )
    
    let addButton = PrimaryButton(
        title: "Add Employee"
    )
    
    // MARK: - Protocol Outputs
    
    var onProfileImageTap: (() -> Void)?
    var onAddButtonTap: (() -> Void)?
    
    // MARK: - Private UI
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center // Center the avatar; we’ll give width constraints to fields/buttons
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Protocol Inputs
    
    var nameText: String? {
        get { nameTextField.text }
        set { nameTextField.text = newValue }
    }
    
    var emailText: String? {
        get { emailTextField.text }
        set { emailTextField.text = newValue }
    }
}

private extension AddEmployeeView {
    func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add arranged subviews
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(addButton)
        
        // Custom spacing
        stackView.setCustomSpacing(24, after: profileImageView)
        stackView.setCustomSpacing(32, after: emailTextField)
        
        // Stack view constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
        
        // Profile image: fixed, centered by stack alignment
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 140),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor)
        ])
        
        // Ensure textfields and button expand to full width
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            emailTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            addButton.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
}

private extension AddEmployeeView {
    func setupActions() {
        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(profileTapped)
        )
        profileImageView.addGestureRecognizer(tapGesture)
        
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    @objc func profileTapped() { onProfileImageTap?() }
    @objc func addTapped() { onAddButtonTap?() }
}

