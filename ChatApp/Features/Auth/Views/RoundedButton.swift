//
//  RoundedButton.swift
//  ChatApp
//
//  Created by Michal Fereniec on 25/09/2022.
//

import UIKit

class RoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
    }
}
