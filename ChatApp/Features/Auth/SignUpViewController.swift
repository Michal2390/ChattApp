//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by Michal Fereniec on 25/09/2022.
//

import UIKit
import FirebaseAuth

class SignUpViewController: AuthTableViewController {
    
    //MARK: Public params
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Private params
    private let segueIdentifier = "segue.Auth.signUpToApp"
    
    //MARK: Public func
    @IBAction func didTapSignUp(_ sender: Any) {
        createUser()
    }
    //MARK: Override func
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        standardSegueToApp(segue: segue, sender: sender)
    }
    
    //MARK: Private func
    private func perform() {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    private func assign(_ username: String, to firebaseUser: FirebaseAuth.User) {
        let changeRequest = firebaseUser.createProfileChangeRequest()
        changeRequest.displayName = username
        
        changeRequest.commitChanges { [weak self]  requestError in
            guard let self = self else { return }
            if let unwrappedRequestError = requestError {
                self.showInvalidFormAlert(with: unwrappedRequestError.localizedDescription)
            } else if let user = User(firebaseUser: firebaseUser) {
                self.performSegue(withIdentifier: self.segueIdentifier, sender: user)
            }
        }
        
    }
    
    private func createUser() {
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        do {
            try validateData()
        } catch {
            if let error = error as? MyError {
                print(error.description)
            }
        }
        
        Auth.auth().createUser(withEmail: email!, password: password!) { [weak self] authResult, authError in
            if let authResult = authResult {
                self?.assign(username!, to: authResult.user)
            } else if let authError = authError {
                self?.showInvalidFormAlert(with: authError.localizedDescription)
            }
        }
    }
    
    private func validateData() throws {
        guard let username = usernameTextField.text, username.count > 3 else {
            throw MyError.notFound
        }
        
        guard let email = emailTextField.text, email.isValidEmail else {
            throw MyError.notFound
        }
        guard let password = passwordTextField.text, password.count > 6 else {
            throw MyError.invalidPassword
        }
    }
}
