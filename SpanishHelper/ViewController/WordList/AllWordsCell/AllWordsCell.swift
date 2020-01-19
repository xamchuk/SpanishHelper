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
    @IBOutlet weak var spanishWordLabel: UILabel!
    @IBOutlet weak var translationWordLabel: UILabel!
    
    // MARK: - Methods
    func set(content: Word) {
        spanishWordLabel.text = content.title
        translationWordLabel.text = content.translation
    }
}

