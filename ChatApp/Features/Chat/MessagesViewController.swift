//
//  MessagesViewController.swift
//  ChatApp
//
//  Created by Michal Fereniec on 26/09/2022.
//

import UIKit
import Firebase
import FirebaseFirestore

class MessagesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: MessageTextView!
    
    @IBOutlet weak var chatContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatContainerViewBottomConstraint: NSLayoutConstraint!
    
    let dataBase = Firestore.firestore()
    lazy var messagesCollection = dataBase.collection("messages")
    
    var user: User!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        messageTextView.growingTextViewDelegate = self
        
        addObservers()
        observeMessages()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: Self.keyboardWillShowNotification,
                                               object: nil,
                                               queue: .main,
                                               using: keyboardWillShow)
        NotificationCenter.default.addObserver(forName: Self.keyboardWillHideNotification,
                                               object: nil,
                                               queue: .main,
                                               using: keyboardWillHide)
    }
    
    func observeMessages() {
        messagesCollection.addSnapshotListener { [weak self] snapshot, _ in
            guard let self = self else { return }
            guard let snapshot = snapshot else { return }
            
            self.messages = snapshot.documents.compactMap {
                guard let sender = $0.data()["sender"] as? String else { return nil }
                guard let body = $0.data()["body"] as? String else { return nil }
                
                return Message(sender: sender, body: body)
            }
            
            self.tableView.reloadData()
            self.tableView.scrollToTheBottom()
        }
    }
    
    func keyboardWillShow (_ notification: Notification) -> Void {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        let bottomInset = view.safeAreaInsets.bottom
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        chatContainerViewBottomConstraint.constant = bottomInset - keyboardHeight
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
            self.tableView.scrollToTheBottom()
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        chatContainerViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 1.0, animations: view.layoutIfNeeded)
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "segue.Chat.messagesToSignIn", sender: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        guard let text = messageTextView.text, !text.isEmpty else { return }
        
        messageTextView.endEditing(true)
        
        let dataDictionary: [String: Any] = ["sender": user.username,
                                             "body": text,
                                             "creationDate": Date()]
        
        messagesCollection.addDocument(data: dataDictionary) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.messageTextView.text.removeAll()
            }
        }
    }
}


extension MessagesViewController: GrowingTextViewDelegate {
    func growingTextView(_ growingTextView: GrowingTextView, heightDidChangeTo height: CGFloat) {
        let verticalPadding: CGFloat = 8
        chatContainerViewHeightConstraint.constant = verticalPadding + height
    }
}

extension MessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell else { return UITableViewCell() }
        
        let message = messages[indexPath.row]
        let isFromCurrentUser = message.sender == user.username
        
        cell.populate(with: message, isFromCurrentUser: isFromCurrentUser)
        
        return cell
    }
}
