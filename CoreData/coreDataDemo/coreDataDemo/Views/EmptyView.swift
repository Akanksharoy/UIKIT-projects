//
//  EmptyView.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.12.2025.
//


import UIKit
final class EmptyView: UIView {
    
    // MARK: - Stored Properties
    
    private let sfSymbolName: String
    private let titleText: String
    private let subtitleText: String
    
    init(
        sfSymbolName: String,
        title: String,
        subtitle: String
    ) {
        self.sfSymbolName = sfSymbolName
        self.titleText = title
        self.subtitleText = subtitle
        super.init(frame: .zero)
        setupUI()
        applyConfiguration()
    }
    
    private let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .systemBackground
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(symbolImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            symbolImageView.widthAnchor.constraint(equalToConstant: 60),
            symbolImageView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    private func applyConfiguration() {
        symbolImageView.image = UIImage(systemName: sfSymbolName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
}
