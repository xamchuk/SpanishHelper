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
        setupNavigationBar()
    }
    
    // MARK: - Action
    @IBAction private func addDidTap(_ sender: Any) {
        coordinator?.addGroup(viewController: self)
    }
    
    // MARK: - Private
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.1638157666, green: 0.445987463, blue: 0.3772965074, alpha: 0.7064961473), #colorLiteral(red: 0.1302538514, green: 0.3544732928, blue: 0.2995031178, alpha: 0.7593910531)], startPoint: .topLeft, endPoint: .bottomLeft)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
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
