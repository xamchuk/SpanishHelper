//
//  WordCheckCollectionViewResultCell.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 25.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class WordCheckCollectionViewResultCell: UICollectionViewCell {
    
    // MARK: - Views
    @IBOutlet weak private var totalWordsLabel: UILabel!
    @IBOutlet weak private var rightWordLabel: UILabel!
    @IBOutlet weak private var wrongWordsLabel: UILabel!
    
    // MARK: - Init Method
    func set(total: Int, right: Int, wrong: Int) {
        totalWordsLabel.text = "\(total)"
        rightWordLabel.text = "\(right)"
        wrongWordsLabel.text = "\(wrong)"
    }
}

