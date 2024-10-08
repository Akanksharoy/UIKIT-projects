//
//  AppsHeaderCell.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 18/08/24.
//

import UIKit
class AppsHeaderCell: UICollectionViewCell {
    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .green
        imageView.backgroundColor = .red
        titleLabel.numberOfLines = 2
        let verticalStackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
    
        addSubview(verticalStackView)
        verticalStackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
