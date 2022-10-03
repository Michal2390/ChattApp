//
//  SignInViewController.swift
//  ChatApp
//
//  Created by Michal Fereniec on 25/09/2022.
//

import UIKit
import FirebaseAuth

class SignInViewController: AuthTableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func didTapSignIn(_ sender: UIButton) {
        signIn()
    }
    
    func signIn() {
        guard
            let email = emailTextField.text,
            email.isValidEmail,
            let password = passwordTextField.text,
            password.count > 6
        else { showInvalidFormAlert(); return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, authError) in
            guard let self = self else { return }
            guard let unwrappedAuthResult = authResult, let user = User(firebaseUser: unwrappedAuthResult.user) else { return }
            self.performSegue(withIdentifier: "segue.Auth.signInToApp", sender: user)
            guard let unwrappedAuthError = authError else { return }
            self.showInvalidFormAlert(with: unwrappedAuthError.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        standardSegueToApp(segue: segue, sender: sender)
    }
}


