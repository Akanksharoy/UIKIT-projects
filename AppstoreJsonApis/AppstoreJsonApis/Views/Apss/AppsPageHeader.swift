//
//  AppsPageHeader.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 18/08/24.
//

import UIKit
class AppsPageHeader: UICollectionReusableView {
    let appsHeaderHorizontalController = AppsHeaderHorizontalController()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(appsHeaderHorizontalController.view)
        appsHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
