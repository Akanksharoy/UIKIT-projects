//
//  PrimaryButton.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.12.2025.
//
import UIKit

final class PrimaryButton: UIButton {
    
    init(title:String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hex: "#3B3FC4")
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        
        layer.cornerRadius = 12
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
}
