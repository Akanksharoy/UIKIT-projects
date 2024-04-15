//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by Animesh on 11/04/24.
//

import UIKit

class AddItemTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    // MARK: - ACTIONS
    @IBAction func done() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(
            in: stringRange,
            with: string)
        print("oldText \(oldText)")
        print("newText \(newText)")
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
}