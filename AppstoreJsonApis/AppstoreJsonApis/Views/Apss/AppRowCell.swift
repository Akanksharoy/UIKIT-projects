//
//  AppRowCell.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 16/08/24.
//

import UIKit
extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        
    }
}
extension UIButton {
    convenience init(title: String) {
        self.init(type: .system )
        self.setTitle(title, for: .normal)
    }
}

class AppRowCell: UICollectionViewCell {
    
    let nameLabel = UILabel(text: "App NAme", font: .systemFont(ofSize: 16))
    let companyLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 13))
    let imageView = UIImageView(cornerRadius: 8)
    let getButton = UIButton(title: "GET")
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .purple
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.layer.cornerRadius = 32 / 2
        getButton.constrainHeight(constant: 32)
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
