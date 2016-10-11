//
//  ViewController.swift
//  CustomUIViewsExamples
//
//  Created by Adrián García Espinosa on 10/10/16.
//  Copyright © 2016 Adrián García Espinosa. All rights reserved.
//

import UIKit
import DropDown

class ViewController: UIViewController {
    
    @IBOutlet weak var mSquareView: SquareView!
    @IBOutlet weak var mWaveView: WaveView!
    
    @IBOutlet weak var mDropDownWave: UIButton!
    @IBOutlet weak var mDropDownSquare: UIButton!
    
    let dropDownSquare = DropDown()
    let dropDownWave = DropDown()
    
    
    @IBOutlet weak var mSquareSlider: UISlider!
    @IBOutlet weak var mWaveSlider: UISlider!
    
    
    // dropdown modes
    var squareSliderMode = 0
    var waveSliderMode = 0
    
    
    
    // Square default values
    let squareOpacityDefault : Double = 1;
    let squareSizeDefault : Int = 100;
    let squareStrokeDefault : Double = 3;
    let squareCornerDefault : Double = 0;
    let squareRotationDefault : Double = 0;
    
    
    // Wave default values
    let waveAmplitudeDefault : Int = 40;
    let waveFreqDefault : Int = 500;
    
    
    @IBAction func toggleWaveMenu(_ sender: UIButton) {
        dropDownWave.show()
    }
    @IBAction func toggleSquareMenu(_ sender: UIButton) {
        dropDownSquare.show()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        dropDownWave.anchorView = mDropDownWave
        dropDownSquare.anchorView = mDropDownSquare
        
        // The list of items to display. Can be changed dynamically
        dropDownWave.dataSource = ["Frequency", "Amplitude"]
        dropDownSquare.dataSource = ["Opacity", "Size", "Stroke Width", "Corner Radius", "Rotation"]
        
        
        // Action triggered on selection
        dropDownSquare.selectionAction = { [unowned self] (index, item) in
            self.mDropDownSquare.setTitle(item, for: .normal)
            self.setUpSquareSlider(propertyIndex: index)
        }
        // Action triggered on selection
        dropDownWave.selectionAction = { [unowned self] (index, item) in
            self.mDropDownWave.setTitle(item, for: .normal)
            self.setUpWaveSlider(propertyIndex: index)
        }
        
        mSquareView.adjustSize(squareSizeDefault)
        mSquareView.adjustOppacity(squareOpacityDefault)
        mSquareView.adjustCornerRadius(squareCornerDefault)
        mSquareView.adjustStrokeWidth(squareStrokeDefault)
        mSquareView.adjustRotation(squareRotationDefault)
        
        mWaveView.adjustFreq(waveFreqDefault)
        mWaveView.adjustAmplitude(waveAmplitudeDefault)
        
        setUpSquareSlider(propertyIndex: 0)
        setUpWaveSlider(propertyIndex: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setUpSquareSlider(propertyIndex: Int) {
        
        squareSliderMode = propertyIndex
        
        switch propertyIndex {
        case 0:
            mSquareSlider.maximumValue = 1
            mSquareSlider.minimumValue = 0
            mSquareSlider.value = Float(squareOpacityDefault)
            
        case 1:
            mSquareSlider.maximumValue = 200
            mSquareSlider.minimumValue = 10
            mSquareSlider.value = Float(squareSizeDefault)
        case 2:
            mSquareSlider.maximumValue = 20
            mSquareSlider.minimumValue = 0
            mSquareSlider.value = Float(squareStrokeDefault)
            
        case 3:
            mSquareSlider.maximumValue = 50
            mSquareSlider.minimumValue = 0
            mSquareSlider.value = Float(squareCornerDefault)
            
        case 4:
            mSquareSlider.maximumValue = Float(M_PI)
            mSquareSlider.minimumValue = 0
            mSquareSlider.value = Float(squareRotationDefault)
            
        default:
            mSquareSlider.maximumValue = 1
            mSquareSlider.minimumValue = 0
            mSquareSlider.value = 1
            
        }
    }
    func setUpWaveSlider(propertyIndex: Int) {
        
        waveSliderMode = propertyIndex
        
        switch propertyIndex {
        case 0:
            mWaveSlider.maximumValue = 1000
            mWaveSlider.minimumValue = 1
            mWaveSlider.value = Float(waveFreqDefault)
            
        case 1:
            mWaveSlider.maximumValue = 100
            mWaveSlider.minimumValue = 0
            mWaveSlider.value = Float(waveAmplitudeDefault)
            
        default:
            mWaveSlider.maximumValue = 1000
            mWaveSlider.minimumValue = 1
            mWaveSlider.value = Float(waveFreqDefault)
        }
        
    }
    @IBAction func SquareSliderChanged(_ sender: UISlider) {
        
        switch squareSliderMode {
        case 0:
            mSquareView.adjustOppacity(Double(sender.value))
        case 1:
            mSquareView.adjustSize(Int(sender.value))
            
        case 2:
            mSquareView.adjustStrokeWidth(Double(sender.value))
        case 3:
            mSquareView.adjustCornerRadius(Double(sender.value))
            
        case 4:
            mSquareView.adjustRotation(Double(sender.value))
        default:
            mSquareView.adjustOppacity(Double(sender.value))
        }
        
    }
    
    @IBAction func waveSliderChanged(_ sender: UISlider) {
        switch waveSliderMode {
        case 0:
            mWaveView.adjustFreq(Int(sender.value))
        case 1:
            mWaveView.adjustAmplitude(Int(sender.value))
        default:
            mWaveView.adjustFreq(Int(sender.value))
        }
    }
    
}

