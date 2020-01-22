//
//  AllWordsSectionFooterView.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 18.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class AllWordsSectionFooterView: UIView {
    
    // MARK: - Views
    @IBOutlet weak private var numberLabel: UILabel!
    
    // MARK: - Init Method
    func set(number: Int) {
        numberLabel.text = "\(number)"
    }
}
