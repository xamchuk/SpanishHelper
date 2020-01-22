//
//  WordListViewController.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 15.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class WordListViewController: UIViewController, Storyboarded {
    
    // MARK: - Views
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    var viewModel: WordListViewModel!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        navigationController?.setupAppDefaultNavigationBar()
    }
    
    // MARK: - Action
    @IBAction private func addDidTap(_ sender: Any) {
        coordinator?.addGroup(viewController: self)
    }
    
    // MARK: - Private
   
    
    private func setupViewModel() {
        viewModel.didDeleteGroup = { [weak self] section in
            self?.tableView.deleteSections(IndexSet(integer: section), with: .fade)
        }
        viewModel.didAddNewGroup = { [weak self] section in
            self?.tableView.insertSections(IndexSet(integer: section), with: .fade)
        }
        
        viewModel?.didAddNewWord = { [weak self] indexPath in
            self?.tableView.insertRows(at: [indexPath], with: .fade)
        }
        
        viewModel?.didUpdateGroup = { [weak self] index in
            self?.tableView.reloadSections(IndexSet(integer: index), with: .fade)
        }
    }
}

// MARK: - UITableViewDataSource
extension WordListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data[section].words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AllWordsCell.self, for: indexPath)
        cell.set(content: viewModel.data[indexPath.section].words[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WordListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: AllWordsSectionHeaderView = .fromNib()
        header.set(title: viewModel.data[section].title)
        header.showMenu = { [weak self] in
            guard let self = self else { return }
            self.coordinator?.presentGroupMenu(viewController: self, at: section)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer: AllWordsSectionFooterView = .fromNib()
        footer.set(number: viewModel.data[section].words.count)
        return footer
    }
}
