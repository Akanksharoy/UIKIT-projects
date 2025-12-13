//
//  EmployeeCell.swift
//  coreDataDemo
//
//  Created by Akanksha on 14.09.2025.
//

import UIKit

class EmployeeCell: UITableViewCell {
    static let reuseID = "EmployeeCell"
    
    // Configure your cell UI here as needed
    // e.g., labels, setup methods, prepareForReuse, etc.
    
    private let employeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let roleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(employeeImageView)
        contentView.addSubview(textStackView)
        
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(roleLabel)
        
        NSLayoutConstraint.activate([
            employeeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            employeeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            employeeImageView.widthAnchor.constraint(equalToConstant: 48),
            employeeImageView.heightAnchor.constraint(equalToConstant: 48),
            
            textStackView.leadingAnchor.constraint(equalTo: employeeImageView.trailingAnchor, constant: 12),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // Make the image view circular
        employeeImageView.layer.cornerRadius = 24
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        employeeImageView.image = nil
        nameLabel.text = nil
        roleLabel.text = nil
    }
    
    // MARK: - Configure
    func configure(with employee: Employee) {
        nameLabel.text = employee.name
        roleLabel.text = employee.email
        
        if let data = employee.profilePicture, let image = UIImage(data: data) {
            employeeImageView.image = image
        } else {
            employeeImageView.image = UIImage(systemName: "person.crop.circle")
        }
    }
}

