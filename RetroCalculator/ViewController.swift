//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Armin Taher on 6/15/17.
//  Copyright © 2017 Armin Taher. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLBL: UILabel!
    
    var btnsound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftvalStr = ""
    var rightValStr = ""
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnsound = AVAudioPlayer(contentsOf: soundURL)
            btnsound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLBL.text = "0"

    }
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLBL.text = runningNumber
    }
    
    @IBAction func ClearPressed(sender: AnyObject){
        processOperation(operation: Operation.Empty)
        outputLBL.text = "0"
        leftvalStr = "0"
        rightValStr = "0"
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        
        if btnsound.isPlaying{
            btnsound.stop()
        }
        btnsound.play()
        
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty{
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    
                    result = "\(Double(leftvalStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftvalStr)! / Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Subtract{
                    
                    result = "\(Double(leftvalStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Add {
                    
                    result = "\(Double(leftvalStr)! + Double(rightValStr)!)"
                    
                }

                leftvalStr = result
                outputLBL.text = result
            }
            
            currentOperation = operation
            
        }else {
            leftvalStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
        
    }


}

