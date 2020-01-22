//
//  ViewController.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 12.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    // MARK: - Init
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Action
    @IBAction private func allWordsDidTap(_ sender: Any) {
        coordinator?.showAllWords(viewModel: WordListViewModel(dataBaseManager: DataBaseManager()))
    }
    @IBAction func wordCheckDidTap(_ sender: Any) {
        coordinator?.wordCheck()
    }
}

