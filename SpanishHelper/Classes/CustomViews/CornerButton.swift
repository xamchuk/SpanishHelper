//
//  cornerButton.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 15.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class CornerButton: UIButton {
    
    // MARK: - Properties
    private let gradient: CAGradientLayer = CAGradientLayer()
    private let imView = UIImageView()
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    @IBInspectable var startPoint: CGPoint = .init(x: 0.5, y: 0)
    @IBInspectable var endPoint: CGPoint = .init(x: 0.5, y: 1)
    @IBInspectable var trailingImageConstant: CGFloat = -16
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            if !cornerRadiusWithHeight {
                layer.cornerRadius = cornerRadius
            }
        }
    }
    
    @IBInspectable var cornerRadiusWithHeight: Bool = false {
        didSet {
            if self.cornerRadiusWithHeight {
                layer.cornerRadius = bounds.height * (1 / 2)
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var imageTrailing: UIImage? {
        didSet {
            imView.image = imageTrailing
        }
    }
    
    @IBInspectable var imageLeading: UIImage? {
        didSet {
            imView.image = imageLeading
        }
    }
    
    @IBInspectable var imageBottom: UIImage? {
        didSet {
            imView.image = imageBottom
        }
    }
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(imView)
        layer.masksToBounds = true
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
        if self.cornerRadiusWithHeight {
            layer.cornerRadius = bounds.height * (1 / 2)
        }
        if imageTrailing != nil {
            imView.translatesAutoresizingMaskIntoConstraints = false
            let ivCenterYAnchor = imView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ivCenterYAnchor.priority = UILayoutPriority(rawValue: 999)
            ivCenterYAnchor.isActive = true
            
            let ivTrailingAnchor = imView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingImageConstant)
            ivTrailingAnchor.priority = UILayoutPriority(rawValue: 999)
            ivTrailingAnchor.isActive = true
        }
        
        if imageLeading != nil {
            imView.translatesAutoresizingMaskIntoConstraints = false
            let ivCenterYAnchor = imView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ivCenterYAnchor.priority = UILayoutPriority(rawValue: 999)
            ivCenterYAnchor.isActive = true
            
            let ivLeadingAnchor = imView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: trailingImageConstant)
            ivLeadingAnchor.priority = UILayoutPriority(rawValue: 999)
            ivLeadingAnchor.isActive = true
        }
        
        if imageBottom != nil {
            imView.translatesAutoresizingMaskIntoConstraints = false
            let ivCenterYXAnchor = imView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ivCenterYXAnchor.priority = UILayoutPriority(rawValue: 999)
            ivCenterYXAnchor.isActive = true
            
            let ivBottomAnchor = imView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: trailingImageConstant)
            ivBottomAnchor.priority = UILayoutPriority(rawValue: 999)
            ivBottomAnchor.isActive = true
        }
    }
}
