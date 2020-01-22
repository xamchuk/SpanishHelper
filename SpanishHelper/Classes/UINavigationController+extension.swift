//
//  UINavigationController+extension.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 20.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setupAppDefaultNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        self.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.1638157666, green: 0.445987463, blue: 0.3772965074, alpha: 0.7064961473), #colorLiteral(red: 0.1302538514, green: 0.3544732928, blue: 0.2995031178, alpha: 0.7593910531)],
                                                                     startPoint: .topLeft,
                                                                     endPoint: .bottomLeft)
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
       }
}
