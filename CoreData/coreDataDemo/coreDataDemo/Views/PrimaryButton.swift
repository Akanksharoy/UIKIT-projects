//
//  PrimaryButton.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.12.2025.
//
import UIKit
//
@IBDesignable
final class PrimaryButton: UIButton {

    // MARK: - Inspectables
    @IBInspectable var cornerRadius: CGFloat = 12 {
        didSet { layer.cornerRadius = cornerRadius }
    }

    @IBInspectable var buttonColor: UIColor = UIColor(hex: "#3B3FC4") {
        didSet { backgroundColor = buttonColor }
    }

    @IBInspectable var minimumHeight: CGFloat = 52 {
        didSet { updateHeightConstraint() }
    }

    // MARK: - Private
    private var heightConstraint: NSLayoutConstraint?

    // MARK: - Initializers
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Setup
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = buttonColor
        setTitleColor(.white, for: .normal)

        // ✅ Dynamic Type
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.numberOfLines = 1

        // Padding instead of fixed height
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 20)

        // Corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true

        // Accessibility
        isAccessibilityElement = true
        accessibilityTraits = .button

        updateHeightConstraint()
    }

    // MARK: - Height Handling
    private func updateHeightConstraint() {
        heightConstraint?.isActive = false
        heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: minimumHeight)
        heightConstraint?.isActive = true
    }

    // MARK: - Interface Builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
}

