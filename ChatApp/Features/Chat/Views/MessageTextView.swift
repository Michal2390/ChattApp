//
//  MessageTextView.swift
//  ChatApp
//
//  Created by Michal Fereniec on 30/09/2022.
//

import UIKit

class MessageTextView: GrowingTextView {

    override func setUpView() {
        super.setUpView()
        
        layer.cornerRadius = 5.0
        placeholderLabel.text = "Enter a message"
    }
}
