//
//  ProfileImageView.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.12.2025.
//

import UIKit

final class ProfileImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        clipsToBounds = true
        image = UIImage(systemName: "camera.fill")
        tintColor = .white
        backgroundColor = .systemGray
        widthAnchor.constraint(equalToConstant: 120).isActive = true
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        layer.cornerRadius = 60
        isUserInteractionEnabled = true
    }
}
