//
//  AppsGroupCell.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 11/08/24.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    let titleLabel: UILabel = UILabel(text: "Apps Section", font: .boldSystemFont(ofSize: 30))
    let horizontalController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .blue
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
