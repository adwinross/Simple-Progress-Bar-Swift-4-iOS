//
//  ProgressBarView.swift
//  BGN
//
//  Created by ARR on 10/11/2017.
//  Copyright © 2017 ARR. All rights reserved.
//

import UIKit
@IBDesignable

class ProgressBarView: UIView {
    @IBInspectable let borderWidth: CGFloat = 1.0
    @IBInspectable let borderColor = UIColor.black
    @IBInspectable var maxValue: Int = 0
    @IBInspectable var currentValue: Int = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable var insideColor = UIColor.gray { didSet { setNeedsDisplay() } }
    @IBInspectable var gradientStartColor = UIColor.white { didSet { setNeedsDisplay() } }
    @IBInspectable var gradientEndColor = UIColor.gray { didSet { setNeedsDisplay() } }
    @IBInspectable var isGradient = true { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        let height: CGFloat = bounds.height
        let width: CGFloat = bounds.width
        
        self.layer.cornerRadius = height/2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        if ((maxValue > 0) && (currentValue > 0)) {
            let divisionLength: CGFloat = width / CGFloat(maxValue)
            
            let bezierPath = self.createBezierPath(length: divisionLength * CGFloat(currentValue))
            
            if isGradient {
                let colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                let colorLocations:[CGFloat] = [0.0, 1.0]
                let gradient = CGGradient(colorsSpace: colorSpace,
                                          colors: colors as CFArray,
                                          locations: colorLocations)
                
                let context = UIGraphicsGetCurrentContext()
                context!.saveGState()
                
                bezierPath.fill()
                bezierPath.addClip()
                
                context!.drawLinearGradient(gradient!, start: CGPoint.zero, end: CGPoint(x: 0, y: height), options: CGGradientDrawingOptions(rawValue: 0))
                
                context!.restoreGState()
            } else {
                insideColor.setFill()
                bezierPath.fill()
            }
        }
    }
    
    func createBezierPath(length: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        if length > 0 {
            let height: CGFloat = self.frame.size.height
            
            let startPoint = CGPoint(x: height / 2, y: 0)
            let lineEndPoint = CGPoint(x:(length - (height / 2)), y: 0)
            
            let arc1Point = CGPoint(x: (length - (height / 2)), y: height / 2)
            let arc2Point = CGPoint(x: height / 2, y: height / 2)
            
            let context = UIGraphicsGetCurrentContext()
            context!.saveGState()
            
            path.move(to: startPoint)
            path.addLine(to: lineEndPoint)
            
            path.addArc(withCenter: arc1Point, radius: height / 2, startAngle: CGFloat(3 * Double.pi/2), endAngle: CGFloat(Double.pi/2), clockwise: true)
            
            path.addLine(to: CGPoint(x: height / 2,y: height))
            
            path.addArc(withCenter: arc2Point, radius: height / 2, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(3 * Double.pi/2), clockwise: true)
            
            path.close()
        }
        
        return path
    }
    
    func drawForValue(value: Int) -> Void {
        currentValue = value
    }
}
