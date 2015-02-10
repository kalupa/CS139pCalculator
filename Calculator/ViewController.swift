//
//  ViewController.swift
//  Calculator
//
//  Created by Paul Kalupnieks on 2015-02-09.
//  Copyright (c) 2015 Paul Kalupnieks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var display: UILabel!

	var userIsTyping = false

	@IBAction func appendDigit(sender: UIButton) {
		let digit = sender.currentTitle!

		if digit == "π" {
			enter()
			displayValue = 3.14159
			enter()
		} else if userIsTyping {
			display.text = display.text! + "\(digit)"
		} else {
			display.text = digit
			userIsTyping = true
		}
	}

	@IBAction func operate(sender: UIButton) {
		let operation = sender.currentTitle!

		println("\(operation)")

		if userIsTyping {
			enter()
		}

		switch operation {
		case "×": performOperation   { $0 * $1  }
		case "÷": performOperation   { $1 / $0  }
		case "+": performOperation   { $0 + $1  }
		case "−": performOperation   { $1 - $0  }
		case "√": performOperation   { sqrt($0) }
		case "sin": performOperation { sin($0)  }
		case "cos": performOperation { cos($0)  }
		default: break
		}
	}

	func performOperation(operation: (Double, Double) -> Double) {
		if operandStack.count >= 2 {
			displayValue = operation(
				operandStack.removeLast(),
				operandStack.removeLast()
			)
			enter()
		}
	}

	func performOperation(operation: Double -> Double) {
		if operandStack.count >= 1 {
			displayValue = operation(operandStack.removeLast())
			enter()
		}
	}

	var operandStack = [Double]()

	@IBAction func enter() {
		userIsTyping = false
		operandStack.append(displayValue)
		println("\(operandStack)")
	}

	var displayValue: Double {
		get{
			return NSNumberFormatter()
				.numberFromString(display.text!)!.doubleValue
		}

		set {
			display.text = "\(newValue)"
			userIsTyping = false
		}
	}
}

