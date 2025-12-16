//
//  ProfileImageView.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.12.2025.
//

import UIKit

final class ProfileImageView: UIView {
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Container styling
        backgroundColor = .secondarySystemBackground
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        // Image view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit // fit SF Symbol nicely
        imageView.clipsToBounds = true
        imageView.tintColor = .systemGray
        imageView.image = UIImage(systemName: "camera.fill") // only the camera icon
        addSubview(imageView)
        
        // Constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
        
        isUserInteractionEnabled = true
        addTapAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2 // make it circular
    }
    
    // Public API to set image
    func setImage(_ image: UIImage?) {
        if let image {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView.image = UIImage(systemName: "camera.fill")
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    private func addTapAnimation() {
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(handlePress(_:)))
        tap.minimumPressDuration = 0
        addGestureRecognizer(tap)
    }
    
    @objc private func handlePress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            animate(scale: 0.96, alpha: 0.9)
        case .ended, .cancelled, .failed:
            animate(scale: 1.0, alpha: 1.0)
        default:
            break
        }
    }
    
    private func animate(scale: CGFloat, alpha: CGFloat) {
        UIView.animate(withDuration: 0.12, delay: 0, options: [.allowUserInteraction, .curveEaseOut]) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.alpha = alpha
        }
    }
}

