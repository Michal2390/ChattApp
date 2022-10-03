//
//  MessageStyleView.swift
//  ChatApp
//
//  Created by Michal Fereniec on 30/09/2022.
//

import UIKit

class MessageStyleView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    func setupView() {
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    
    func design(as messageStyle: MessageStyle) {
        switch messageStyle {
        case .sent:
            backgroundColor = UIColor(named: "customGray")  
            layer.borderWidth = 0
            layer.borderColor = UIColor.clear.cgColor
        case .received:
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = UIColor(named: "customGray")?.cgColor
        }
    }
}
