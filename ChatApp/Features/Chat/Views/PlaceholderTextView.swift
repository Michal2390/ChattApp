//
//  PlaceholderTextView.swift
//  ChatApp
//
//  Created by Michal Fereniec on 30/09/2022.
//

import UIKit

class PlaceholderTextView: UITextView {

   let placeholderLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }
    
    func setUpView() {
        delegate = self
        
        placeholderLabel.frame = CGRect(x: 5, y: 0, width: bounds.width, height: bounds.height)
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = font
        placeholderLabel.text = "Enter a message"
        
        addSubview(placeholderLabel)

    }
}

extension PlaceholderTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
