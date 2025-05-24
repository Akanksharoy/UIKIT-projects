//
//  AppRowCell.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 16/08/24.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.backgroundColor = .red
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.layer.cornerRadius = 16
        getButton.setContentHuggingPriority(.required, for: .horizontal)
        
        let labelsStack = VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, labelsStack, getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 0, bottom: 8, right: 16))
        imageView.constrainHeight(to: stackView.heightAnchor, multiplier: 0.8)
        imageView.constrainWidth(to: imageView.heightAnchor, multiplier: 1.0)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
