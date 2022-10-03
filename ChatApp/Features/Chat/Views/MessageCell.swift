//
//  MessageCell.swift
//  ChatApp
//
//  Created by Michal Fereniec on 30/09/2022.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var senderUsernameLabel: UILabel!
    @IBOutlet weak var messageStyleView: MessageStyleView!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    func populate(with message: Message, isFromCurrentUser: Bool) {
        senderUsernameLabel.text = message.sender
        messageBodyLabel.text = message.body
        
        contentStackView.alignment = isFromCurrentUser ? .trailing : .leading
        let style: MessageStyle = isFromCurrentUser ? .sent : .received
        messageStyleView.design(as: style)
    }
}
