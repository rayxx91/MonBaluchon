//
//  ChangeViewController.swift
//  odysee
//
//  Created by chaleroux on 04/10/2021.
//

import UIKit

class ChangeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var eurContainerView: UIView!
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var exchangeButton: CustomButton!
    @IBOutlet weak var moneyPickerView: UIPickerView!
    
    // MARK: Proprieties
    
    let exchange = ExchangeService()
    let moneyChoice = ["Australian Dollar", "Canadian Dollar", "Swiss Franc", "British Pound Sterling", "Mexicain Peso", "New Zealand Dollar", "United States Dollar"]
    
    // MARK: Life Cycle
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        setupUI()
    }
    
    // MARK: Setup
    
    private func setupVC() {
        // Do any additional setup after loading the view.
        
        //        let moneyPickerView = UIView()
        
        moneyPickerView.isHidden = true
        //Je renseigne que le delegue de moneyPickerView s'accroche a ChangeViewController
        self.moneyPickerView.delegate = self
        self.moneyPickerView.dataSource = self
        
        self.euroTextField.delegate = self
        
        
    }
    
    func setupUI() {
        
        usdButton.layer.cornerRadius = 8
        
        exchangeButton.setupUI(size: 16, color: .white, title: "Exchange")
    }
    
    // MARK: Methods
    
    func convert() {
        
        exchange.getExchange { (rates, err)  in
            
            if let error = err {
                self.alert(title: "ERROR", message: error.localizedDescription)
            } else if let rate = rates {
                self.calculate(data: rate)
            }
        }
    }
    
    func calculate(data: FixerResponse) {
        
        // I create a let to stock information to know which money compare
        guard let currency = usdButton.titleLabel?.text else { return }
        
        // Stock the entry information and switch it in Int
        guard let enterPrice = euroTextField.text,
              let price = Double(enterPrice) else { return }
        
        // Stock the rate
        guard let rate = data.rates[currency] else { return }
        
        //Do the calcul
        let currencyCalcul = Double(price) * rate
        print(rate)
        print(currencyCalcul)
        deviceTextField.text = "\(currencyCalcul)"
    }
    
    func alert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: IBActions
    
    @IBAction func usdChoiceButton(_ sender: UIButton) {
        
        moneyPickerView.isHidden = false
        eurContainerView.alpha = 0.7
        exchangeButton.alpha = 0.7
    }
    
    @IBAction func exchangeButtomTapped(_ sender: UIButton) {
      
        view.endEditing(true)
      
        if let numberOfcharactere = euroTextField.text?.count {
            print(numberOfcharactere)
            guard numberOfcharactere > 0 else {
                alert(title: "Erreur", message: "Saississez un montant!")
                return
            }
            
            convert()
        }
    }
    
    
    // MARK: UIPickerView DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moneyChoice.count
    }
    
    // MARK: UIPickerView Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moneyChoice[row]
    }
    
    //didSelectRow: tell you when a row was selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let myChoice = moneyChoice[row]
        let capturedTheResult = exchange.abreviateDeviseName(for: myChoice)
        
        UIView.animate(withDuration: 0.3) {
            
            self.usdButton.setTitle(capturedTheResult, for: .normal)
            self.eurContainerView.alpha = 1.0
            self.exchangeButton.alpha = 1.0
            self.moneyPickerView.isHidden = true
            
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newCharacter = string
        
        //I create a tab of my authorized numbers
        let listOfAcceptedCharachers: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", ""]
        
        //Is my new character part of the accepted characters ?
        if listOfAcceptedCharachers.contains(newCharacter) {
            return true
        } else {
            return false
        }
    }
}

