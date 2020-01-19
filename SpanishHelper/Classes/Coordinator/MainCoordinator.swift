//
//  MainCoordinator.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 15.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showAllWords(viewModel: WordListViewModel) {
        let vc = WordListViewController.instantiate()
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentGroupMenu(viewController: WordListViewController, at index: Int) {
        let vc = GroupMenuPopUpController.instantiate()
        viewController.present(vc, animated: false)
        vc.addNewWord = { word, translation in
            viewController.viewModel.addNewWord(word: word, translation: translation, at: index)
        }
        
        vc.renameGroup = {
            print("rename")
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
    
    
}
