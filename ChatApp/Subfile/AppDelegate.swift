//
//  AppDelegate.swift
//  ChatApp
//
//  Created by Michal Fereniec on 25/09/2022.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func checkAuthSignIn() {
        guard let firebaseUser = Auth.auth().currentUser,
            let user = User(firebaseUser: firebaseUser)
            else { return }
        
        let chatStoryboard = UIStoryboard(name: "Chat", bundle: .main)
        guard let navigationController = chatStoryboard.instantiateInitialViewController() as? UINavigationController,
              let messagesViewController = navigationController.topViewController as? MessagesViewController
        else { return }
        
        messagesViewController.user = user
        
        window?.rootViewController = navigationController
    }

}

