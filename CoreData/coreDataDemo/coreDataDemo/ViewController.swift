//
//  ViewController.swift
//  coreDataDemo
//
//  Created by Animesh on 10.09.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - UI
    
    private let tableView = UITableView()
    
    private let emptyView = EmptyView(
        sfSymbolName: "person.2.slash",
        title: "No Employees",
        subtitle: "Employees added will appear here."
    )
    
    // MARK: - Dependencies
    
    private let viewModel: EmployeeListViewModelProtocol
    
    // MARK: - Init
    
    init(viewModel: EmployeeListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // If this VC is loaded from a storyboard/nib, provide a default ViewModel wiring here.
    required init?(coder: NSCoder) {
        // Default dependency graph for storyboard usage
        let repository = EmployeeDataRepository()
        let vm = EmployeeListViewModel(repository: repository)
        self.viewModel = vm
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)

        viewModel.loadEmployees()
        reloadUI()
    }

    private func setupAddButton() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = addButton
    }

    @objc
    private func addButtonTapped() {
        print("Add button tapped")
        // Navigate to Add Employee screen later
    }
    
    func reloadUI() {
        let isEmpty = viewModel.employees.isEmpty
        emptyView.isHidden = !isEmpty
        tableView.isHidden = isEmpty
        tableView.reloadData()
    }
    
    func setupUI() {
        title = "Employees"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setupNavigationBar()
        setupAddButton()
        setupTableView()
        setupEmptyView()
   
    }
    private func setupNavigationBar() {
        title = "Employees"

        let backgroundColor = UIColor(hex: "#3B3FC4")

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }


    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 72
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 76, bottom: 0, right: 0)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupEmptyView() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.employees.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EmployeeCell.reuseID,
            for: indexPath
        ) as! EmployeeCell
        
        let employee = viewModel.employees[indexPath.row]
        cell.configure(with: employee)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] _, _, completion in
            
            guard let self else { return }
            
            let employee = self.viewModel.employees[indexPath.row]
            _ = self.viewModel.deleteEmployee(id: employee.id)
            self.reloadUI()
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = CGFloat((int >> 16) & 0xFF) / 255
        let g = CGFloat((int >> 8) & 0xFF) / 255
        let b = CGFloat(int & 0xFF) / 255

        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
