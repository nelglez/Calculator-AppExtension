//
//  TodayViewController.swift
//  CalculatorWidget
//
//  Created by Nelson Gonzalez on 4/8/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit
import NotificationCenter
import RPN

class TodayViewController: UIViewController, NCWidgetProviding, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var stackView4: UIStackView!
    @IBOutlet weak var stackView5: UIStackView!
    
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.maximumIntegerDigits = 20
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        return formatter
    }()
    
    private var calculator = Calculator() {
        didSet {
            if let value = calculator.topValue {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    
    private var digitAccumulator = DigitAccumulator() {
        didSet {
            if let value = digitAccumulator.value() {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
           preferredContentSize = maxSize
            stackView1.isHidden = true
            stackView2.isHidden = true
            stackView3.isHidden = true
            stackView4.isHidden = true
            stackView5.isHidden = true
            
        case .expanded:
           preferredContentSize = CGSize(width: maxSize.width, height: 450)
           stackView1.isHidden = false
           stackView2.isHidden = false
           stackView3.isHidden = false
           stackView4.isHidden = false
           stackView5.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .number(sender.tag))
    }
    
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .decimalPoint)
    }
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        // Take the value from the accumulator and push it to the stack
        
        if let value = digitAccumulator.value() {
            calculator.push(value)
        }
        digitAccumulator.clear()
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .divide)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .multiply)
    }
    
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .subtract)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .add)
    }
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        
        UIPasteboard.general.string = textField.text
        textField.text = ""
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // If you want to do something when the text field gets cleared, you can do so now.
        calculator.clearStack()
        digitAccumulator.clear()
        return true
    }
    
    
    
    
}
