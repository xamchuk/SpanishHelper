//
//  RoundedView.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 16.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import UIKit

final class RoundedView: UIView {
    enum Corners: Int {
        case topLeft = 1, topRight = 2, bottomLeft = 3, bottomRight = 4, all = 5, top = 6, bottom = 7, none = 0
    }
    
    // MARK: - Properties
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var maskedCorners: Int = 5 {
        didSet {
            guard let cc = Corners.init(rawValue: maskedCorners) else { return }
            corners = cc
        }
    }
    var corners = Corners.all
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth / 2
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: -1, height: 3) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 2 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
             layer.cornerRadius = cornerRadius
            if !cornerRadiusWithHeight {
                switch corners {
                case .topLeft:
                    layer.maskedCorners = [.layerMinXMinYCorner]
                case .topRight:
                    layer.maskedCorners = [.layerMaxXMinYCorner]
                case .bottomLeft:
                    layer.maskedCorners = [.layerMinXMaxYCorner]
                case .bottomRight:
                    layer.maskedCorners = [.layerMaxXMaxYCorner]
                case .all:
                    layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                case .top:
                    layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                case .bottom:
                    layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                case .none:
                    layer.maskedCorners = []
                }
            }
        }
    }
    @IBInspectable var gradientAlpha: Float = 1 {
        didSet {
            gradient.opacity = gradientAlpha
        }
    }
    @IBInspectable var cornerRadiusWithHeight: Bool = false
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    @IBInspectable var startPoint: CGPoint = .init(x: 0.5, y: 0)
    @IBInspectable var endPoint: CGPoint = .init(x: 0.5, y: 1)
    @IBInspectable var isGradient: Bool = false {
        didSet {
            drawGradient()
        }
    }
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
    private func drawGradient() {
        if !cornerRadiusWithHeight {
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
            gradient.frame = bounds
            gradient.colors = [startColor.cgColor, endColor.cgColor]
            gradient.zPosition = -1
            layer.addSublayer(gradient)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isGradient {
            gradient.frame = bounds
        }
        if self.cornerRadiusWithHeight {
            layer.cornerRadius = bounds.height * (0.5)
        }
    }
}

