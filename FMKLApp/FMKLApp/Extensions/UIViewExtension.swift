//
//  UIView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

extension UIView {
    func roundCorners(topLeft: CGFloat, topRight: CGFloat, bottomRight: CGFloat, bottomLeft: CGFloat) {
        let path = UIBezierPath()
        let size = self.bounds.size
        
        // Start at the top left corner
        path.move(to: CGPoint(x: 0, y: topLeft))
        
        // Top left corner
        path.addArc(withCenter: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: .pi, endAngle: 3 * .pi / 2, clockwise: true)
        
        // Top edge
        path.addLine(to: CGPoint(x: size.width - topRight, y: 0))
        
        // Top right corner
        path.addArc(withCenter: CGPoint(x: size.width - topRight, y: topRight), radius: topRight, startAngle: 3 * .pi / 2, endAngle: 0, clockwise: true)
        
        // Right edge
        path.addLine(to: CGPoint(x: size.width, y: size.height - bottomRight))
        
        // Bottom right corner
        path.addArc(withCenter: CGPoint(x: size.width - bottomRight, y: size.height - bottomRight), radius: bottomRight, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        
        // Bottom edge
        path.addLine(to: CGPoint(x: bottomLeft, y: size.height))
        
        // Bottom left corner
        path.addArc(withCenter: CGPoint(x: bottomLeft, y: size.height - bottomLeft), radius: bottomLeft, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
        
        // Left edge
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        
        // Close the path
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
