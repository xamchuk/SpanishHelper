//
//  WordCheckViewController.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 20.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class WordCheckViewController: UIViewController, Storyboarded {
    
    // MARK: - Views
    @IBOutlet weak private var valuesStackView: UIStackView!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var totalWordsCountLabel: UILabel!
    @IBOutlet weak private var rightCountLabel: UILabel!
    @IBOutlet weak private var wrongCountLabel: UILabel!
    @IBOutlet weak private var wrongButton: CornerButton!
    @IBOutlet weak private var rightButton: CornerButton!
    @IBOutlet weak private var retryButton: CornerButton!
    
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    var viewModel: WordCheckViewModel!
    private lazy var currentIndexPath: IndexPath = .init(row: 0, section: 0)
    private lazy var rightCount: Int = 0
    private lazy var wrongCount: Int = 0
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupAppDefaultNavigationBar()
        totalWordsCountLabel.text = "\(viewModel.data.count)"
    }
    
    // MARK: - Action
    @IBAction private func menuDIdTap(_ sender: Any) {
        let word = (currentIndexPath.row == viewModel.data.count) ? nil : viewModel.data[currentIndexPath.row]
        coordinator?.showAllWords(for: .withSelectedRow(word: word ))
    }
    
    @IBAction private func rightDidTap(_ sender: Any) {
        countAnswers(label: rightCountLabel, counter: &rightCount)
        animateCellImage(isRight: true)
    }
    
    @IBAction private func wrongDidTap(_ sender: Any) {
        countAnswers(label: wrongCountLabel, counter: &wrongCount)
       animateCellImage(isRight: false)
    }
    @IBAction func retryDidTap(_ sender: Any) {
        currentIndexPath = .init(row: 0, section: 0)
        rightCount = 0
        wrongCount = 0
        rightCountLabel.text = "\(rightCount)"
        wrongCountLabel.text = "\(wrongCount)"
        collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
        UIView.animate(withDuration: 0.3, animations:  { [weak self] in
            self?.retryButton.isHidden = true
            self?.wrongButton.isHidden = false
            self?.rightButton.isHidden = false
            self?.valuesStackView.alpha = 1
            
        }) { [weak self] (_) in
            self?.wrongButton.isUserInteractionEnabled = true
            self?.rightButton.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - Private
    private func scrollToNextWord() {
        currentIndexPath.row += 1
        if self.currentIndexPath.row == self.viewModel.data.count {
            self.finishWordCheck()
            collectionView.reloadItems(at: [currentIndexPath])
        }
        collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func animateCellImage(isRight: Bool) {
        wrongButton.isUserInteractionEnabled = false
        rightButton.isUserInteractionEnabled = false
        if let cell = collectionView.cellForItem(at: currentIndexPath) as? WordCheckCollectionViewCell {
            cell.showAnimatedImage(isRightAnswer: isRight) { [weak self] in
                self?.scrollToNextWord()
                self?.wrongButton.isUserInteractionEnabled = true
                self?.rightButton.isUserInteractionEnabled = true
            }
        }
    }
    
    private func finishWordCheck() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.valuesStackView.alpha = 0
            self?.retryButton.isHidden = false
            self?.wrongButton.isHidden = true
            self?.rightButton.isHidden = true
        }
    }
    
    private func countAnswers(label: UILabel, counter: inout Int) {
        counter += 1
        label.text = "\(counter)"
    }
}


// MARK: - UICollectionViewDataSource
extension WordCheckViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == viewModel.data.count {
            let cell = collectionView.dequeueReusableCell(with: WordCheckCollectionViewResultCell.self, for: indexPath)
            cell.set(total: viewModel.data.count, right: rightCount, wrong: wrongCount)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(with: WordCheckCollectionViewCell.self, for: indexPath)
        let content = WordCheckCollectionViewCell.Content(word: viewModel.data[indexPath.row].title, translation:  viewModel.data[indexPath.row].translation)
        cell.set(content: content)
       
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WordCheckViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 96)
        return .init(width: width, height: collectionView.frame.height)
    }
}
