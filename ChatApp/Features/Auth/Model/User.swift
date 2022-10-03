//
//  User.swift
//  ChatApp
//
//  Created by Michal Fereniec on 26/09/2022.
//

import Foundation
import FirebaseAuth

struct User {
    let username: String
    let email: String
    let uid: String
    
    init?(firebaseUser: FirebaseAuth.User) {
        guard
            let displayName = firebaseUser.displayName,
            let email = firebaseUser.email
        else { return nil }
        
        self.username = displayName
        self.email = email
        self.uid = firebaseUser.uid
    }
}
