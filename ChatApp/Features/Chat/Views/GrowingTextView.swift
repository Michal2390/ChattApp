//
//  GrowingTextView.swift
//  ChatApp
//
//  Created by Michal Fereniec on 30/09/2022.
//

import UIKit

protocol GrowingTextViewDelegate: AnyObject {
    //func heightDidChange(to height: CGFloat)
    func growingTextView(_ growingTextView: GrowingTextView, heightDidChangeTo height: CGFloat)
    
}

class GrowingTextView: PlaceholderTextView {

    weak var growingTextViewDelegate: GrowingTextViewDelegate?
    var maxHeight: CGFloat = 105.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    func configure() {
        isScrollEnabled = false
    }
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        
        let width = bounds.width
        let newSize = sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        let newHeight = newSize.height
         
        let finalHeight = newHeight > maxHeight ? maxHeight : newHeight
        isScrollEnabled = newHeight > maxHeight 
        growingTextViewDelegate?.growingTextView(self, heightDidChangeTo: finalHeight)
    }
}
