//
//  AppsPageHeader.swift
//  AppstoreJsonApis
//
//  Created by Akanksha on 18/08/24.
//

import UIKit
class AppsPageHeader: UICollectionReusableView {
    var appsHeaderHorizontalController: AppsHeaderHorizontalController?

    func configure(with viewModel: AppsHeaderHorizontalViewModelProtocol) {
        appsHeaderHorizontalController?.view.removeFromSuperview()

        let controller = AppsHeaderHorizontalController(viewModel: viewModel)
        appsHeaderHorizontalController = controller

        addSubview(controller.view)
        controller.view.fillSuperview()
    }
}
