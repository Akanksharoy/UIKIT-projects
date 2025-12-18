//
//  AddEmployeeViewController.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.12.2025.
//

import UIKit

final class AddEmployeeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let contentView: AddEmployeeViewProtocol
    private let viewModel: AddEditEmployeeViewModelProtocol
    
    
    init(
        contentView: AddEmployeeViewProtocol = AddEmployeeView(),
        viewModel: AddEditEmployeeViewModelProtocol
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        bindActions()
        configureInitialData()
    }
    
    func configureInitialData() {
        contentView.nameText = viewModel.name
        contentView.emailText = viewModel.email

        if let data = viewModel.profileImageData,
           let image = UIImage(data: data) {
            contentView.setProfileImage(image)
        }
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true)

        let image =
            (info[.editedImage] as? UIImage) ??
            (info[.originalImage] as? UIImage)

        guard let selectedImage = image else { return }

        let imageData = selectedImage.jpegData(compressionQuality: 0.8)

        viewModel.updateProfileImage(data: imageData)
        contentView.setProfileImage(selectedImage)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
}

private extension AddEmployeeViewController {
    
    func setupNavigation() {
        title = viewModel.name == nil ? "Add Employee" : "Edit Employee"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func bindActions() {
        contentView.onProfileImageTap = { [weak self] in
            self?.presentImagePicker()
        }
        
        contentView.onAddButtonTap = { [weak self] in
            self?.addEmployee()
        }
    }
    
    func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
   
    
    func addEmployee() {
        guard
            let name = contentView.nameText, !name.isEmpty,
            let email = contentView.emailText, !email.isEmpty
        else {
            return
        }
        
        viewModel.save(
            name: name,
            email: email,
        )
        navigationController?.popViewController(animated: true)
    }
}
