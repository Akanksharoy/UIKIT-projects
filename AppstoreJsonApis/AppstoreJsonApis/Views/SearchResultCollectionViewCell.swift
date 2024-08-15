//
//  SearchResultCollectionViewCell.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 20/06/24.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    var app: Apps! {
        didSet {
            nameLabel.text = app.trackName
            categoryLabel.text = app.primaryGenreName
            ratingsLabel.text = "Ratings: \(app.averageUserRating ?? 0)"
            appIconImageView.sd_setImage(with: URL(string: app.artworkUrl100))
            screenshot1ImageView.sd_setImage(with: URL(string: app.screenshotUrls[0]))
            screenshot2ImageView.sd_setImage(with: URL(string: app.screenshotUrls[1]))
            screenshot3ImageView.sd_setImage(with: URL(string: app.screenshotUrls[2]))
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 84).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 84).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAme"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 12
        return button
    }()
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()
    
    func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        labelsStackView.axis = .vertical
        
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoTopStackView.alignment = .center
        infoTopStackView.spacing = 12
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [
            infoTopStackView, screenshotsStackView], spacing: 16)
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
