//
//  CheckButton.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 18.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class CheckButton: UIButton {
    
    // MARK: - Views
    @IBInspectable var checkedImage: UIImage?
    @IBInspectable var uncheckedImage: UIImage? {
        didSet {
            setImage(uncheckedImage, for: .normal)
        }
    }
    
    // MARK: - Properties
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    // MARK: - Init
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    // MARK: - Action
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
