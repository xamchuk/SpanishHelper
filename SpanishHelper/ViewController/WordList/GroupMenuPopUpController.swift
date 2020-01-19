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
    @IBOutlet weak private var addWordStackView: UIView!
    @IBOutlet weak private var wordTextField: UITextField!
    @IBOutlet weak private var translationTextFiled: UITextField!
    @IBOutlet weak private var addWordButton: UIButton!
    
    // MARK: - Constraints
    @IBOutlet weak private var containerViewYAnchor: NSLayoutConstraint!
    @IBOutlet private var addWordContainerBottomAnchor: NSLayoutConstraint!
    
    // MARK: - Public Properties
    var renameGroup: (() -> Void)?
    var deleteGroup: (() -> Void)?
    var addNewWord: ((String, String) -> Void)?
    
    // MARK: - Private Properties
    private var isExpanded: Bool = false
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        addWordContainerBottomAnchor.isActive = false
        view.layoutIfNeeded()
        view.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.2) {  [weak self] in
            self?.view.alpha = 1
        }
    }
    
    // MARK: - Actions
    @IBAction private func renameDidTap(_ sender: Any) {
        renameGroup?()
        dismisViewController()
    }
    
    @IBAction private func deleteDidTap(_ sender: Any) {
        deleteGroup?()
        dismisViewController()
    }
    
    @IBAction private func addNewWordDidTap(_ sender: Any) {
        expandNewWordContainer(isExpanded: isExpanded)
        isExpanded.toggle()
    }
    
    @IBAction private func didEditTextFiled(_ sender: Any) {
        guard let word = wordTextField.text,
            let translation = translationTextFiled.text else { return }
        addWordButton.isEnabled = (word.count > 0 && translation.count > 0)
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
    
    private func addWord() {
        guard let word = wordTextField.text,
            let translation = translationTextFiled.text else { return }
        addNewWord?(word, translation)
    }
}

// MARK: - UITextFieldDelegate
extension GroupMenuPopUpController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
