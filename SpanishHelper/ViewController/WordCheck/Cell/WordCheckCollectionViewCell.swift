//
//  WordCheckCollectionViewCell.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 22.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class WordCheckCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    @IBOutlet weak var wordView: RoundedView!
    @IBOutlet weak var translationView: RoundedView!
    @IBOutlet weak var backgroundWordLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var backgroundTranslationLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    // MARK: - Properties
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        wordView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flip)))
        translationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flip)))
    }
    
    func set(content: Content) {
        wordLabel.text = content.word
        backgroundWordLabel.text = content.word
        translationLabel.text = content.translation
        backgroundTranslationLabel.text = content.translation
    }
    
    // MARK: - Action
    @objc private func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: wordView, duration: 0.5, options: transitionOptions, animations: {
            self.wordView.alpha = self.wordView.alpha == 0 ? 1 : 0
        })
        
        UIView.transition(with: translationView, duration: 0.5, options: transitionOptions, animations: {
            self.translationView.alpha = self.translationView.alpha == 0 ? 1 : 0
        })
    }
    
    // MARK: - Private
}

// MARK: - Content
extension WordCheckCollectionViewCell {
    struct Content {
        var word: String
        var translation: String
    }
}
