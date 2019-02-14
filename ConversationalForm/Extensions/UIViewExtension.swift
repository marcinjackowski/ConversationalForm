//
//  UIViewExtension.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 14/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

extension UIView{
    func roundCorners(topLeft: CGFloat = 0.0, topRight: CGFloat = 0.0, bottomLeft: CGFloat = 0.0, bottomRight: CGFloat = 0.0, borderColor: UIColor, borderWidth: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
        layer.masksToBounds = true
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = (layer.mask! as! CAShapeLayer).path!
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}
