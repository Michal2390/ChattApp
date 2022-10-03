//
//  AuthTableViewController.swift
//  ChatApp
//
//  Created by Michal Fereniec on 25/09/2022.
//

import UIKit

class AuthTableViewController: UITableViewController {
    
    func showInvalidFormAlert(with message: String? = nil) {
        let alertMessage = message ?? "Make sure u typed correct and secure enough credentials"
        let alert = UIAlertController(title: "Invalid Credentials", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func standardSegueToApp(segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
        let messagesViewController = navController.topViewController as? MessagesViewController,
        let user = sender as? User {
            messagesViewController.user = user
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight = super.tableView(tableView, heightForRowAt: indexPath)
        
        guard indexPath.row == 0 else { return defaultHeight }
        
        return tableView.bounds.height * 0.42
    }
    
}
