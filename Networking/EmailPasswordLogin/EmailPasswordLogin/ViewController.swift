//
//  ViewController.swift
//  EmailPasswordLogin
//
//  Created by 阮迅 on 2021/8/29.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    // TODO: Create a title label
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Log In"
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        return titleLabel
    }()
    
    private let emailTextField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email Address"
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.backgroundColor = .white
        emailField.autocapitalizationType = .none
        // MARK: How to add a spacer equivalent in UIKit
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        return emailField
    }()
    
    private let passwordTextField: UITextField = {
        let passField = UITextField()
        passField.placeholder = "Password"
        passField.layer.borderWidth = 1
        passField.layer.borderColor = UIColor.black.cgColor
        passField.isSecureTextEntry = true
        passField.backgroundColor = .white
        passField.leftViewMode = .always
        passField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return passField
    }()
    
    // MARK: How to create an inline UIView
    private let logInButton: UIButton = {   // {} is a closure without parameter
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    private let signOutbutton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign Out", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.backgroundColor = .systemPurple
        logInButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        if FirebaseAuth.Auth.auth().currentUser != nil {    // MARK: get the current user in Firebase
            titleLabel.isHidden = true
            logInButton.isHidden = true
            emailTextField.isHidden = true
            passwordTextField.isHidden = true
            
            
            view.addSubview(signOutbutton)
            signOutbutton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width - 40, height: 52)
            signOutbutton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        }
    }
    
    @objc private func logOutTapped(){
        do {
            try FirebaseAuth.Auth.auth().signOut()  // MARK: Sign out the current user in Firebase
            
            titleLabel.isHidden = false
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            logInButton.isHidden = false
            
            signOutbutton.removeFromSuperview() // MARK: Delete a view
        } catch {
            print("An error occurred")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // MARK: Set the default cursor at a view
        titleLabel.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(x: 0,
                                  y: 100,
                                  width: view.frame.size.width,
                                  height: 80)
        
        emailTextField.frame = CGRect(x: 20,
                                      y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 10,
                                      width: view.frame.size.width-40,
                                      height: 50)
        
        passwordTextField.frame = CGRect(x: 20,
                                         y: emailTextField.frame.origin.y + emailTextField.frame.size.height + 10,
                                         width: view.frame.size.width-40,
                                         height: 50)
        
        logInButton.frame = CGRect(x: 20,
                                   y: passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 30,
                                   width: view.frame.size.width-40,
                                   height: 52)
    }
    
    @objc private func didTapButton(){
        print("Continue button tapped")
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Missing field data")
            return
        }
        
        // Get auth instance
        // MARK: Sign in in Firebase
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                // MARK: if failure, present alert to create account
                print("Create an account")
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            
            // MARK: - You have signed in -
            
            strongSelf.titleLabel.isHidden = true
            strongSelf.emailTextField.isHidden = true
            strongSelf.passwordTextField.isHidden = true
            strongSelf.logInButton.isHidden = true
        })
        
        
        // check sign in on app launch
        // allow user to sign out with button
    }
    
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    // TODO: Show account creation
                    print("Account creation failed")
                    return
                }
                
                // MARK: - You have signed in -
                strongSelf.titleLabel.isHidden = true
                strongSelf.emailTextField.isHidden = true
                strongSelf.passwordTextField.isHidden = true
                strongSelf.logInButton.isHidden = true
                
                strongSelf.emailTextField.resignFirstResponder()
                strongSelf.passwordTextField.resignFirstResponder()
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true)
    }
    
}

