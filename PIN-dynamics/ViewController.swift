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
    private var passcode: String = "030510"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var TestPinInputVisualiser: UILabel!
    
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
        
    }
    
    
    private func addValueToPinInput(value: String)
    {
        if pinInput.count < 6 {
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
                newInputData.dateTime = .now
                
                do {
                    try context.save()
                }
                catch {
                    
                }
                
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
        // reset the passcode to a new random passcode
        passcode = ""
        for _ in 1...6 {
            let i = Int.random(in: 0..<10)
            passcode += String(i)
        }
        passcodeDisplay.text = passcode
        
        // reset circles to be unfilled
        for circle in outlines{
            circle.image = UIImage(systemName: "circle")
        }
        // reset inputted digits to be empty
        pinInput = ""
        TestPinInputVisualiser.text = "test"
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
    
    @IBAction func onetap(_ sender: Any) {
        addValueToPinInput(value: "1")
        validatePin()   }
    @IBAction func twotap(_ sender: Any) {
        addValueToPinInput(value: "2")
        validatePin()   }
    @IBAction func threetap(_ sender: Any) {
        addValueToPinInput(value: "3")
        validatePin()   }
    @IBAction func fourtap(_ sender: Any) {
        addValueToPinInput(value: "4")
        validatePin()   }
    @IBAction func fivetap(_ sender: Any) {
        addValueToPinInput(value: "5")
        validatePin()   }
    @IBAction func sixtap(_ sender: Any) {
        addValueToPinInput(value: "6")
        validatePin()   }
    @IBAction func seventap(_ sender: Any) {
        addValueToPinInput(value: "7")
        validatePin()   }
    @IBAction func eighttap(_ sender: Any) {
        addValueToPinInput(value: "8")
        validatePin()   }
    @IBAction func ninetap(_ sender: Any) {
        addValueToPinInput(value: "9")
        validatePin()   }
    @IBAction func zerotap(_ sender: Any) {
        addValueToPinInput(value: "0")
        validatePin()    }
}

