//
//  RoundedTextField.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.12.2025.
//

import UIKit

final class RoundedTextField: UITextField {
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        
        font = .systemFont(ofSize: 16)
        autocorrectionType = .no
        autocapitalizationType = .none
        
        // Padding
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        leftViewMode = .always
        
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
