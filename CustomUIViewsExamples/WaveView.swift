//
//  WaveView.swift
//  CustomUIViewsExamples
//
//  Created by Adrián García Espinosa on 10/10/16.
//  Copyright © 2016 Adrián García Espinosa. All rights reserved.
//

import UIKit

@IBDesignable
class WaveView: UIView {

    
    @IBInspectable
    var steps : Int = 500 // Divide the curve into steps
    
    @IBInspectable
    var amp : Int = 40
    
    @IBInspectable
    var resolution : Double = 0.1
    
    
    override func draw(_ rect: CGRect) {
        
        // Draw a sine curve with a fill
        
        let centerY = frame.height / 2  // find the vertical center
        
        let stepX = frame.width / CGFloat(steps) // find the horizontal step distance
        
        // Make a path
        let path = UIBezierPath()
        // Start in the lower left corner
        //path.move(to: CGPoint(x: 0, y: frame.height))
        // Draw a line up to the vertical center
        path.move(to: CGPoint(x: 0, y: centerY))
        // Loop and draw steps in straingt line segments
        for i in 0...steps {
            let x = CGFloat(i) * stepX
            let y = (sin(Double(i) * resolution) * Double(amp)) + Double(centerY)
            path.addLine(to: CGPoint(x: x, y: CGFloat(y)))
        }
        
        
        // Draw down to the lower right
        //path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        // Close the path
        //path.close()
        // Render the path
        UIColor.red.setStroke()
        path.stroke()
        // let strokeColor = UIColor.redColor()
        // strokeColor.setStroke()
        // path.lineWidth = 3
        // path.stroke()
    }
    
    
    func adjustFreq(_ freq: Int) {
        steps = freq
        setNeedsDisplay()
    }
    
    func adjustAmplitude(_ amp: Int) {
        var newAmp = amp
    
        if amp > min(Int(frame.width)/2, Int(frame.height)/2) {
            newAmp = Int(min(frame.width, frame.height)/2)
        }
        self.amp = newAmp
        setNeedsDisplay()
    }
 
}
