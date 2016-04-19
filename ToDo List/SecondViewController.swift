//
//  SecondViewController.swift
//  ToDo List
//  
//  Daniel Lorenzo 2640 - 001
//  Created by [ r∆ven ] on 3/6/16.
//  Copyright © 2016 Salt Lake Community College. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myTextField: UITextField!
    
    @IBAction func myButton(sender: AnyObject) {
        
        toDoList.append(myTextField.text!)
        myTextField.text=""
        
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
        
    }
    
    
    //MARK: - Outlets and properties
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var countingDown: UISwitch!
    
    var timer = NSTimer() //make a timer variable, but do do anything yet
    let timeInterval:NSTimeInterval = 0.06
    let timerEnd:NSTimeInterval = 7.0
    var timeCount:NSTimeInterval = 0.0
    //MARK: - Actions
    
    @IBAction func startTimer(sender: UIButton) {
        
        if !timer.valid{ //prevent more than one timer on the thread
            timerLabel.text = timeString(timeCount)
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval,
                target: self,
                selector: "timerDidEnd:",
                userInfo: "Pizza Done!!",
                repeats: true) //repeating timer in the second iteration
        }
    }
    
    @IBAction func countingDown(sender: UISwitch) {
        if !timer.valid{ //if we stopped an
            resetTimeCount()
        }
    }
    @IBAction func stopTimer(sender: UIButton) {
        //timerLabel.text = "Timer Stopped"
        timer.invalidate()
    }
    
    @IBAction func resetTimer(sender: UIButton) {
        timer.invalidate()
        resetTimeCount()
        timerLabel.text = timeString(timeCount)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.myTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Close keyboard with a tap outside the keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    // Call when return button pressed - closes keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder() // Closes.
        
        return true
        
    }


    
    
    // Reset timer method.
    func resetTimeCount(){
        if countingDown.on{
            timeCount = timerEnd
        } else {
            timeCount = 0.0
        }
    }
    
    // Display time logic.
    func timeString(time:NSTimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10.0))
    }
    
    // Condition to test when timer ends.
    func timerDidEnd(timer:NSTimer){
        
        
        if countingDown.on{
            // Color Timer
            timeCount = timeCount - timeInterval
            if timeCount <= 0 {
                timerLabel.text = "Your Hair Coloring is Done!"
                timer.invalidate()
            } else { // Keep updating to screen.
                timerLabel.text = timeString(timeCount)
            }
            
        } else {
            // Bleach Timer
            timeCount = timeCount + timeInterval
            if timeCount >= timerEnd{
                timerLabel.text = "Wash the bleach out before you go bald!"
                timer.invalidate()
            } else { // Keep updating to screen.
                timerLabel.text = timeString(timeCount)
            }
            
        }
        
    }
    
    
    
    
    
}

