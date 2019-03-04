//
//  ViewController.swift
//  Calculator
//
//  Created by Deepesh on 04/03/19.
//  Copyright © 2019 deepesh deshmukh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var displayNum: UILabel!

    var previousNum : Double = 0
    var currentNumber : Double = 0
    var preTag = "+"
    let tagList = ["+","-","*","/"]
    var modOccured = false
    var decimal : Bool = false
    
    var audioPlayer : AVAudioPlayer!
    let url = Bundle.main.url(forResource: "click", withExtension: "wav")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func numButtonsPressed(_ sender: UIButton) {
        playSound()
        //print(sender.tag)
        if (displayNum.text! == "0" || displayNum.text! == "+" || displayNum.text! == "-" || displayNum.text! == "*" || displayNum.text! == "/" || modOccured ) && !(sender.tag == 0) && !(sender.tag==100){
            displayNum.text = String(sender.tag)
        }
        else if sender.tag == 100 && !decimal{
            decimal = true
            displayNum.text = displayNum.text! + "."
        }
        else if !(displayNum.text! == "0") && !(sender.tag == 100){
            displayNum.text = displayNum.text! + String(sender.tag)
        }
    }
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        playSound()
        if previousNum==0 {
            previousNum = Double(displayNum.text!) ?? 0
            decimal = false
        }
        else{
           // decimal = true
            currentNumber = Double(displayNum.text!) ?? 0
            if preTag == "+"{
                previousNum += currentNumber
            }
            else if preTag == "-"{
                previousNum -= currentNumber
            }
            else if preTag == "*"{
                previousNum *= currentNumber
            }
            else if preTag == "/"{
                previousNum /= currentNumber
            }
        }
        
        if sender.tag == 4{
            currentNumber = Double(displayNum.text!) ?? 0
            previousNum = currentNumber/100
            modOccured = true
            decimal = true
        }
        
        if sender.tag == 10 || sender.tag == 4{
            decimal = true
            displayNum.text = String(previousNum)
            previousNum = 0
            preTag = "+"
        }
        else{
            displayNum.text = String(tagList[sender.tag])
            preTag = tagList[sender.tag]
        }
    }
    
    
    @IBAction func clearScreen(_ sender: UIButton) {
        playSound()
        displayNum.text = "0"
        previousNum = 0
        currentNumber = 0
        preTag = "+"
        modOccured = false
        decimal = false
    }
    
    
    @IBAction func invertnum(_ sender: UIButton) {
        playSound()
        currentNumber = Double(displayNum.text!) ?? 0
        currentNumber = -currentNumber
        displayNum.text = String(currentNumber)
        previousNum = currentNumber
    }
    
    
    @IBAction func erase(_ sender: UIButton) {
        playSound()
        if displayNum.text!.count > 1{
            let index = displayNum.text!.index(before: displayNum.text!.endIndex)
            displayNum.text = String(displayNum.text![..<index])
            let dotCheck = displayNum.text!.firstIndex(of: ".") ?? displayNum.text!.endIndex
            if dotCheck == displayNum.text!.endIndex{
                decimal = false
            }
            //print(String(displayNum.text![..<index]))
        }
        else if displayNum.text!.count == 1{
            displayNum.text = "0"
            decimal = false
        }
    }
    
    func playSound(){
        audioPlayer = try? AVAudioPlayer(contentsOf: url!)
        audioPlayer.play()
        
    }
    

}

