//
//  AllWordsSectionHeaderView.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 18.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class AllWordsSectionHeaderView: UIView {
    
    // MARK: - Views
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Public Properties
    var showMenu: (() -> Void)?
    
    // MARK: - Init Method
    func set(title: String?) {
        titleLabel.text = title
    }
    
    // MARK: - Action
    @IBAction func menuDidTap(_ sender: Any) {
        showMenu?()
    }
}
