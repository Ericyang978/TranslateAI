//
//  SettingViewController.swift
//  
//
//  Created by Eric Yang (student LM) on 5/6/21.
//

//original text
//translated text
//voice controller timer
//voice controller auto start?
//voice controller auto stop?

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var originalTextDecider: UISwitch!//switch that determines whether original text is shown or not
    
    @IBOutlet weak var translatedTextDecider: UISwitch! //switch that determines whether translated text is shown or not
    @IBOutlet weak var timerAutostartDecider: UISwitch!
        //switch that determines whether or not the timer autostarts
    
    @IBOutlet weak var timerDeciderString: UITextField!
    @IBOutlet weak var timerDeciderDisplayValue: UITextView!
    
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
           super.viewDidLoad()
        
        
    //originalTextDecider code
        //if there is no value in defaults, set on (only happens once)
        if defaults.string(forKey: "originalTextDeciderState") == nil  {
            originalTextDecider.setOn(true, animated: true)
        }
        //if set to on when the view was dismissed, then re-set the value to on
        else if defaults.string(forKey: "originalTextDeciderState") == "on" {
            originalTextDecider.setOn(true, animated: true)
        }
        // if set to off when the view was dismissed, then re-set the value to off
        else {
            originalTextDecider.setOn(false, animated: true)

        }
        
    //translatedTextDecidercode
        //if there is no value in defaults, set on (only happens once)
        if defaults.string(forKey: "translatedTextDeciderState") == nil  {
            translatedTextDecider.setOn(true, animated: true)
        }
        //if set to on when the view was dismissed, then re-set the value to on
        else if defaults.string(forKey: "translatedTextDeciderState") == "on" {
            translatedTextDecider.setOn(true, animated: true)
        }
        // if set to off when the view was dismissed, then re-set the value to off
        else {
            translatedTextDecider.setOn(false, animated: true)
        }
    //Voice Controller auto start
        if defaults.string(forKey: "timerAutostartDeciderState") == nil  {
            timerAutostartDecider.setOn(true, animated: true)
        }
               //if set to on when the view was dismis4sed, then re-set the value to on
        else if defaults.string(forKey: "timerAutostartDeciderState") == "on" {
            timerAutostartDecider.setOn(true, animated: true)
        }
               // if set to off when the view was dismissed, then re-set the value to off
        else {
            timerAutostartDecider.setOn(false, animated: true)
        }
    //voice controller timer, displays the value of the timer at the current moment
        timerDeciderDisplayValue.text = defaults.string(forKey: "timerDeciderStringState") ?? "2"
    
        
        

       }
  
    //used when the view disappears
     override func viewDidDisappear(_ animated: Bool) {
        
    //originalTextDecider code
        if originalTextDecider.isOn{
        defaults.set("on", forKey: "originalTextDeciderState")
        }
        else{
        defaults.set("off", forKey: "originalTextDeciderState")
        }
        
    //translatedTextDecidercode
        if translatedTextDecider.isOn{
        defaults.set("on", forKey: "translatedTextDeciderState")
        }
        else{
        defaults.set("off", forKey: "translatedTextDeciderState")
        }
    //Voice controller autostart
        if timerAutostartDecider.isOn{
            defaults.set("on", forKey: "timerAutostartDeciderState")
        }
        else{
        defaults.set("off", forKey: "timerAutostartDeciderState")
        }
    //Voice controller timer
        //if the user does not constantly update the timerDeciderString, it will autoset to "" and make the default value "", so it cannot equal "" when updating
        if timerDeciderString.text != ""{
            //update the default with a value for timerDeciderString
            defaults.set(timerDeciderString.text, forKey: "timerDeciderStringState")
        }
    }
    
//    @IBAction func originalTextDecision(_ sender: UISwitch) {
//        if sender.isOn{
//            print("hello i am here")
//        MessagesViewController.shared.sendOriginalText = true
//        }
//        else {
//            MessagesViewController.shared.sendOriginalText = false
//
//        }
//
        
        
    }
    
    
    
    
    
    
    
    
