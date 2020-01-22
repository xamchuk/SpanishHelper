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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalWordsCountLabel: UILabel!
    @IBOutlet weak var rightCountLabel: UILabel!
    @IBOutlet weak var wrongCountLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: WordCheckViewModel!
    private lazy var curentIndexPath: IndexPath = .init(row: 0, section: 0)
    private lazy var rightCount: Int = 0
    private lazy var wrongCount: Int = 0
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupAppDefaultNavigationBar()
    }
    
    // MARK: - Action

    
    @IBAction private func menuDIdTap(_ sender: Any) {
        
    }
    
    @IBAction private func rightDidTap(_ sender: Any) {
        countAnswers(label: rightCountLabel, counter: &rightCount)
        scrollToNextWord()
    }
    
    @IBAction private func wrongDidTap(_ sender: Any) {
        countAnswers(label: wrongCountLabel, counter: &wrongCount)
        scrollToNextWord()
    }
    
    // MARK: - Private
    private func scrollToNextWord() {
        guard  curentIndexPath.row != viewModel.data.count - 1 else  {
            finishWordCheck()
            return
        }
        
        curentIndexPath.row += 1
        collectionView.scrollToItem(at: curentIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func finishWordCheck() {
        
    }
    
    private func countAnswers(label: UILabel, counter: inout Int) {
        counter += 1
        label.text = "\(counter)"
    }
}


// MARK: - UICollectionViewDataSource
extension WordCheckViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
