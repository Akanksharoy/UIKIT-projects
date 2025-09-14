//
//  EmployeeCell.swift
//  coreDataDemo
//
//  Created by Animesh on 14.09.2025.
//

import UIKit

class EmployeeCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func configure(with employee: Employee, using viewModel: EmployeeListViewModelProtocol) {
        nameLabel.text = viewModel.displayName(for: employee)
        emailLabel.text = viewModel.displayEmail(for: employee)
        profileImageView.image = viewModel.profileImage(for: employee)
    }
}
