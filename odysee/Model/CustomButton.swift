//
//  CustomButton.swift
//  MonBaluchon
//
//  Created by chaleroux on 28/01/2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    let cornerRadius: CGFloat = 12
    
    func setupUI(size: CGFloat, color: UIColor, title: String) {
        
        layer.cornerRadius = cornerRadius
        
        let titleAttributeString = NSAttributedString(string: title, attributes: [
            .foregroundColor: color,
            .font: UIFont.boldSystemFont(ofSize: size)
        ])
        
        setAttributedTitle(titleAttributeString, for: .normal)
    }
}
