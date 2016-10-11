//
//  SquareView.swift
//  CustomUIViewsExamples
//
//  Created by Adrián García Espinosa on 10/10/16.
//  Copyright © 2016 Adrián García Espinosa. All rights reserved.
//

import UIKit

@IBDesignable
class SquareView: UIView {

    @IBInspectable
    var strokeWidth : Double = 3.0
    
    @IBInspectable
    var xPosition : Double = 10
    
    @IBInspectable
    var yPosition : Double = 10
    
    @IBInspectable
    var width : Double = 100
    
    @IBInspectable
    var heigth : Double = 100
    
    @IBInspectable
    var centerView : Bool = false
    
    @IBInspectable
    var pressed : Bool = false
    
    @IBInspectable
    var radians : Double = 0

    @IBInspectable
    var mAlpha : Double = 0
    
    var strockeColor : UIColor = UIColor.green
    
    var fillColor : UIColor = UIColor.red
    
    
    @IBInspectable
    var cornerRadius : Double = 0
    
    
    
    
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if centerView {
            xPosition = Double(frame.width/2) - width/2
            yPosition = Double(frame.height/2) - heigth/2
        }
        
        if pressed {
            strockeColor = UIColor.red
            fillColor = UIColor.green
        } else{
            strockeColor = UIColor.green
            fillColor = UIColor.red
        }
        let rect = CGRect(x: xPosition, y: yPosition, width: width, height: heigth)
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(cornerRadius))
        
        
        // translate to origin
        let bounds = path.cgPath.boundingBox
        let center = CGPoint(x:bounds.midX, y:bounds.midY)
        let toOrigin = CGAffineTransform(translationX: -center.x, y: -center.y)
        path.apply(toOrigin)
        
        // rotate
        let rotation = CGAffineTransform(rotationAngle: CGFloat(radians))
        path.apply(rotation)
        
        
        // back to previous place
        let fromOrigin = CGAffineTransform(translationX: center.x, y: center.y)
        path.apply(fromOrigin)
        
        
        path.lineWidth = CGFloat(strokeWidth)
        strockeColor.setStroke()
        fillColor.setFill()
        path.fill(with:CGBlendMode.normal, alpha: CGFloat(mAlpha))
        path.stroke(with:CGBlendMode.normal, alpha: CGFloat(mAlpha))
    }
    
    
   
    func toggleState(){
        pressed = !pressed
        setNeedsDisplay()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SquareView.handleTap))
        //  tap.delegate = self
        self.addGestureRecognizer(tap)
        
    }
    
    
    func handleTap() {
        toggleState()
    }
    
    func adjustCornerRadius(_ r: Double ) {
        cornerRadius = r
        setNeedsDisplay()
    }
    func adjustOppacity(_ alpha: Double) {
        mAlpha = alpha
        setNeedsDisplay()
    }
    
    func adjustRotation(_ radians: Double) {
        self.radians = radians
        setNeedsDisplay()
    }
    
    func adjustSize(_ size: Int) {
        var newSize = size
        if size > min(Int(bounds.size.width), Int(bounds.size.height)) {
            newSize = min(Int(bounds.size.width), Int(bounds.size.height))
        }
        self.width = Double(newSize)
        self.heigth = Double(newSize)
        setNeedsDisplay()
    }

    func adjustStrokeWidth(_ width: Double) {
        self.strokeWidth = width
        setNeedsDisplay()
    }
}
