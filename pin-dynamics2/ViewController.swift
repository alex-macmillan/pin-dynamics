//
//  ViewController.swift
//  PIN-dynamics
//
//  Created by alex on 01/04/2025.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    private var pinInput: String = ""
    private var passcode: String = "000000"
    private var currentUserAttempts = 6
    private var touchLocations: [CGPoint] = []
    private var touchIntervals: [TimeInterval] = []
    private var lastTouchTime: TimeInterval?
    private var currentTouchTime: TimeInterval?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var TestPinInputVisualiser: UILabel!
    @IBOutlet weak var CompletedAttemptsVisualiser: UILabel!
    
    @IBOutlet weak var passcodeDisplay: UILabel!
    private var outlines: [UIImageView] = []
    
    @IBOutlet weak var outline1: UIImageView!
    @IBOutlet weak var outline2: UIImageView!
    @IBOutlet weak var outline3: UIImageView!
    @IBOutlet weak var outline4: UIImageView!
    @IBOutlet weak var outline5: UIImageView!
    @IBOutlet weak var outline6: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outlines = [outline1, outline2, outline3, outline4, outline5, outline6]
        
        reset()
        whereIsMySqlite()
        TestPinInputVisualiser.text = ""
        CompletedAttemptsVisualiser.text = "0/5"
    }
    
    
    private func addValueToPinInput(value: String)
    {
        if pinInput.count < 6{
            pinInput += "\(value)"
            fillIndicatorOutline()
            TestPinInputVisualiser.text = pinInput
        }
    }
    
    private func validatePin()
    {
        if pinInput.count == 6 {
            if pinInput == passcode{
                let newInputData = PinInputData(context: self.context)
                newInputData.passcode = passcode
                newInputData.dateTime = Date()
                newInputData.x1 = Double(touchLocations[0].x)
                newInputData.y1 = Double(touchLocations[0].y)
                newInputData.x2 = Double(touchLocations[1].x)
                newInputData.y2 = Double(touchLocations[1].y)
                newInputData.x3 = Double(touchLocations[2].x)
                newInputData.y3 = Double(touchLocations[2].y)
                newInputData.x4 = Double(touchLocations[3].x)
                newInputData.y4 = Double(touchLocations[3].y)
                newInputData.x5 = Double(touchLocations[4].x)
                newInputData.y5 = Double(touchLocations[4].y)
                newInputData.interval1 = Double(touchIntervals[0])
                newInputData.interval2 = Double(touchIntervals[1])
                newInputData.interval3 = Double(touchIntervals[2])
                newInputData.interval4 = Double(touchIntervals[3])
                do {
                    try context.save()
                }
                catch {
                    
                }
                currentUserAttempts += 1
                CompletedAttemptsVisualiser.text = "\(currentUserAttempts)/5"
            } else {
                print("pininput error")
            }
            reset()
        }
    }
    
    private func fillIndicatorOutline()
    {
        let index = pinInput.count - 1
        if index >= 0 && index < outlines.count {
            outlines[index].image = UIImage(systemName: "circle.fill")
        }
    }
    
    private func reset() {
        // after 5 completed attempts, reset the passcode to a new random passcode
        if currentUserAttempts > 4 {
            passcode = ""
            for _ in 1...6 {
                let i = Int.random(in: 0..<10)
                passcode += String(i)
            }
            passcodeDisplay.text = passcode
            currentUserAttempts = 0
            CompletedAttemptsVisualiser.text = "0/5"
        }
        
        // reset circles to be unfilled
        for circle in outlines{
            circle.image = UIImage(systemName: "circle")
        }
        // reset inputted digits to be empty
        pinInput = ""
        TestPinInputVisualiser.text = ""
        // reset current session touches
        touchLocations = []
        touchIntervals = []
        lastTouchTime = nil
        currentTouchTime = nil
    }
    
    func touchLocation(sender: UIButton, event: UIEvent){
        if let touch = event.allTouches?.first {
            let location = touch.location(in: sender)
            touchLocations.append(location)
            print("X: \(location.x), Y: \(location.y)")
        }
    }
    
    func touchTimings(sender: UIButton, event: UIEvent){
        if let touch = event.allTouches?.first {
            currentTouchTime = touch.timestamp
            if let last = lastTouchTime, let current = currentTouchTime {
                touchIntervals.append(current - last)
                print("appended \(current - last)")
            } else {
                print("first attempt of session")
            }
            lastTouchTime = touch.timestamp
        }
    }
    
    func touchTimes(sender:UIButton, event: UIEvent){
    }
    
    func whereIsMySqlite(){
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print(path ?? "Not found")
    }
    
    @IBAction func onetap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "1" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "1")
            validatePin()   }}
    @IBAction func twotap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "2" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "2")
            validatePin()    }}
    @IBAction func threetap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "3" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "3")
            validatePin()    }}
    @IBAction func fourtap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "4" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "4")
            validatePin()    }}
    @IBAction func fivetap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "5" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "5")
            validatePin()    }}
    @IBAction func sixtap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "6" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "6")
            validatePin()   }}
    @IBAction func seventap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "7" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "7")
            validatePin()   }}
    @IBAction func eighttap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "8" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "8")
            validatePin()    }}
    @IBAction func ninetap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "9" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "9")
            validatePin()    }}
    @IBAction func zerotap(_ sender: UIButton, forEvent event: UIEvent) {
        let strIndex = passcode.index(passcode.startIndex, offsetBy: pinInput.count)
        if String(passcode[strIndex]) == "0" {
            touchLocation(sender: sender, event: event)
            touchTimings(sender: sender, event: event)
            addValueToPinInput(value: "0")
            validatePin()   }}
}
