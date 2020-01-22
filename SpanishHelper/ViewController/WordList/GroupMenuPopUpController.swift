//
//  GroupMenuPopUpController.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 19.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class GroupMenuPopUpController: UIViewController, Storyboarded {
    
    // MARK: - Views
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var addWordStackView: UIView!
    @IBOutlet weak private var wordTextField: UITextField!
    @IBOutlet weak private var renameTextField: UITextField!
    @IBOutlet weak private var translationTextFiled: UITextField!
    @IBOutlet weak private var addWordButton: UIButton!
    @IBOutlet weak var renameButton: UIButton!
    
    
    // MARK: - Constraints
    @IBOutlet weak private var containerViewYAnchor: NSLayoutConstraint!
    @IBOutlet private var addWordContainerBottomAnchor: NSLayoutConstraint!
    
    @IBOutlet private var renameContainerBottomAnchor: NSLayoutConstraint!
    
    // MARK: - Public Properties
    var renameGroup: ((String) -> Void)?
    var deleteGroup: (() -> Void)?
    var addNewWord: ((String, String) -> Void)?
    
    // MARK: - Private Properties
    private var isAddWordExpanded: Bool = false
    private var isRenameExpanded: Bool = false
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        addWordContainerBottomAnchor.isActive = false
        renameContainerBottomAnchor.isActive = false
        view.layoutIfNeeded()
        view.alpha = 0
        titleLabel.text = title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.2) {  [weak self] in
            self?.view.alpha = 1
        }
    }
    
    // MARK: - Actions
    @IBAction private func renameDidTap(_ sender: Any) {
        if isAddWordExpanded {
            isAddWordExpanded.toggle()
            expandNewWordContainer(isExpanded: isAddWordExpanded)
        }
        expandRenameContainer()
    }
    
    @IBAction private func deleteDidTap(_ sender: Any) {
        deleteGroup?()
        dismisViewController()
    }
    
    @IBAction private func addNewWordDidTap(_ sender: Any) {
        if isRenameExpanded {
            expandRenameContainer()
        }
        expandNewWordContainer(isExpanded: isAddWordExpanded)
        isAddWordExpanded.toggle()
    }
    
    @IBAction func didEditRenameTextField(_ sender: Any) {
        guard let newTitle = renameTextField.text else { return }
        renameButton.isEnabled = newTitle.count > 0
    }
    
    @IBAction private func didEditAddWordTextFileds(_ sender: Any) {
        guard let word = wordTextField.text,
            let translation = translationTextFiled.text else { return }
        addWordButton.isEnabled = (word.count > 0 && translation.count > 0)
    }
    
    @IBAction func renameButtonDidTap(_ sender: Any) {
       guard let newTitle = renameTextField.text else { return }
        titleLabel.text = newTitle
        renameGroup?(newTitle)
        expandRenameContainer()
    }
    

    @IBAction private func addDidTap(_ sender: Any) {
        addWord()
        dismisViewController()
    }
    
    @IBAction private func closeTapped(_ sender: Any) {
      dismisViewController()
    }
    
    // MARK: - Private
    private func dismisViewController() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.alpha = 0
        }) { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        }
    }
    
    private func expandNewWordContainer(isExpanded: Bool) {
        let height = addWordStackView.frame.height / 2
        if isExpanded {
            containerViewYAnchor.constant = 0
            view.endEditing(true)
        } else {
            containerViewYAnchor.constant = -height
            wordTextField.becomeFirstResponder()
        }
        
        addWordContainerBottomAnchor.isActive.toggle()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func expandRenameContainer() {
        if isAddWordExpanded {
            isAddWordExpanded.toggle()
            expandNewWordContainer(isExpanded: isAddWordExpanded)
        }
        renameContainerBottomAnchor.isActive.toggle()
        if renameContainerBottomAnchor.isActive {
            renameTextField.becomeFirstResponder()
        } else {
            renameTextField.resignFirstResponder()
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        isRenameExpanded.toggle()
    }
    
    private func addWord() {
        guard let word = wordTextField.text,
            let translation = translationTextFiled.text else { return }
        addNewWord?(word, translation)
    }
}

// MARK: - UITextFieldDelegate
extension GroupMenuPopUpController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == renameTextField {
            guard let title = textField.text else { return true }
            renameGroup?(title)
            titleLabel.text = title
            expandRenameContainer()
        }
        
        if textField == wordTextField {
            wordTextField.resignFirstResponder()
            translationTextFiled.becomeFirstResponder()
        }
        
        if textField == translationTextFiled {
            translationTextFiled.resignFirstResponder()
            addWord()
            dismisViewController()
        }
        return true
    }
}
