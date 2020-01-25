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
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var menuButton: UIButton!
    
    // MARK: - Public Properties
    var showMenu: (() -> Void)?
    
    // MARK: - Init Method
    func set(title: String?, menuIsHidden: Bool) {
        titleLabel.text = title
        menuButton.isHidden = menuIsHidden
    }
    
    // MARK: - Action
    @IBAction private func menuDidTap(_ sender: Any) {
        showMenu?()
    }
}
