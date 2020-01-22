//
//  CreateGroupViewController.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 19.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class CreateGroupViewController: UIViewController, Storyboarded {
    
    // MARK: - Views
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var createButton: UIButton!
    
    // MARK: - Properties
    var createGroup: ((String) -> Void)?
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
              self?.view.alpha = 1
        }) { [weak self] (_) in
            self?.textField.becomeFirstResponder()
        }
    }
    
    // MARK: - Actions
    @IBAction private func didEditTextField(_ sender: UITextField) {
        guard let text = sender.text else { return }
        createButton.isEnabled = text.count >= 1
    }
    
    @IBAction private func createDidTap(_ sender: Any) {
        guard let text = textField.text else { return }
        createGroup?(text)
        dismisViewController()
    }
    
    @IBAction private func closeTapped(_ sender: Any) {
        textField.resignFirstResponder()
        dismisViewController()
    }
    
    // MARK: - Private
    private func dismisViewController() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.view.alpha = 0
        }) { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate
extension CreateGroupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createDidTap(UIButton())
        return true
    }
}

