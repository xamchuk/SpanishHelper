//
//  MainCoordinator.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 15.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showAllWords(for state: WordListViewController.State ) {
        let vc = WordListViewController.instantiate()
        vc.state = state
        vc.viewModel = WordListViewModel(dataBaseManager: DataBaseManager())
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentGroupMenu(viewController: WordListViewController, at index: Int) {
        let vc = GroupMenuPopUpController.instantiate()
        vc.title = viewController.viewModel.data[index].title ?? ""
        viewController.present(vc, animated: false)
        
        vc.addNewWord = { word, translation in
            viewController.viewModel.addNewWord(word: word, translation: translation, at: index)
        }
        
        vc.renameGroup = { newTitle in
            viewController.viewModel.renameGroup(newTitle: newTitle, at: index)
        }
        
        vc.deleteGroup = {
            viewController.viewModel.deleteGroup(at: index)
        }
    }
    
    func addGroup(viewController: WordListViewController) {
        let vc = CreateGroupViewController.instantiate()
        vc.createGroup = {
            viewController.viewModel.addNewGroup(title: $0)
        }
        viewController.present(vc, animated: false)
    }
    
    func wordCheck() {
        let vc = WordCheckViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = WordCheckViewModel(dataBaseManager: DataBaseManager())
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
