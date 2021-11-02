//
//  ChangeViewController.swift
//  odysee
//
//  Created by chaleroux on 04/10/2021.
//

import UIKit

class ChangeViewController: UIViewController {
    
    @IBOutlet var numbersButton: [UIButton]!
    @IBOutlet weak var upTextField: UITextField!
    @IBOutlet weak var decimalButton: UIButton! {
        didSet {
            decimalButton.layer.cornerRadius = 15.0
            decimalButton.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var resetButton: UIButton! {
        didSet {
            resetButton.layer.cornerRadius = 15.0
            resetButton.clipsToBounds = true
        }
    }
    
    
    var numbers = String()
    var expressionIsEmpty: Bool {
        return upTextField.text == "" || upTextField.text == "0"
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedNumbersButton(_ sender: UIButton) {
        if expressionIsEmpty {
            upTextField.text = ""
        }
        guard let numberText = sender.title(for: .normal) else { return }
        
        upTextField.text?.append(numberText)
        numbers += numberText
    }
    
    @IBAction func tappedDecimalButton(_sender: UIButton) {
        
    }
    
    @IBAction func tappedResetButton(_ sender: UIButton) {
        upTextField.text = "0"
        numbers = ""
    }
    
}
