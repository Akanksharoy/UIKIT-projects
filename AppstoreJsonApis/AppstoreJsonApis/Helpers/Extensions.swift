//
//  Extensions.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 16/08/24.
//

import UIKit
extension UILabel {
    convenience  init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}
