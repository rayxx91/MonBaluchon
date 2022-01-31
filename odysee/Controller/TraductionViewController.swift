//
//  TraductionViewController.swift
//  odysee
//
//  Created by chaleroux on 07/12/2021.
//

import UIKit
import SwiftUI

class TraductionViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var translateButton: CustomButton!
    @IBOutlet weak var resultTranslationTextView: UITextView!
    @IBOutlet weak var textFillTextView: UITextView!
    
    // MARK: Proprieties
    
    private var translateService = Translate()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Methods
    
    func updateTranslation() {
        let text = textFillTextView.text!
        let api = Translate(session: URLSession(configuration: .default))
        api.getTraduction(text: text) { (Translate, error) in
            if let error = error {
                self.alert(title: "ERROR", message: error.localizedDescription)
            } else {
                self.showTranslation(data: Translate!)
            }
        }
    }
    
    // display translation from first language to second
    func showTranslation(data: Translation) {
        resultTranslationTextView.text = data.data.translations[0].translatedText
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    func setupUI() {
        
        navigationController?.navigationBar.tintColor = .white
        
        textFillTextView.layer.cornerRadius = 12
        resultTranslationTextView.layer.cornerRadius = 12
        translateButton.setupUI(size: 16, color: .black, title: "Translate")
    }
    
    // MARK: IBActions
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        guard textFillTextView.text != nil else {
            // send an alert to enter a value to translate
            alert(title: "Erreur", message: "Entrez une langue !")
            return
        }
        guard textFillTextView.text != "" else {
            // send an alert to enter a value to convert
            alert(title: "Erreur", message: "Tapez un texte !")
            return
        }
        
        updateTranslation()
    }
    
}
    
        
