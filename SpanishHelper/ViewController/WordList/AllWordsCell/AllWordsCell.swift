//
//  AllWordsCell.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 15.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class AllWordsCell: UITableViewCell {
    
    // MARK: - Views
    @IBOutlet weak private var spanishWordLabel: UILabel!
    @IBOutlet weak private var translationWordLabel: UILabel!
    @IBOutlet weak var containerView: RoundedView!
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? #colorLiteral(red: 0.8894792199, green: 0.1182090268, blue: 0.007130811457, alpha: 0.5371896404) : .white
        }
    }
    
    // MARK: - Methods
    func set(content: Word) {
        spanishWordLabel.text = content.title
        translationWordLabel.text = content.translation
        
    }
}

