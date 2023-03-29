//
//  LoginViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 29.03.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private lazy var enterEmail = {
        let input = UITextField()
        input.placeholder = "Email"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        return input
    }()
    
    private lazy var enterPassword = {
        let input = UITextField()
        input.placeholder = "Password"
        input.borderStyle = .roundedRect
        input.isSecureTextEntry = true
        input.autocapitalizationType = .none
        return input
    }()
    
    private lazy var signUpButton = {
        let button = UIButton()
        button.changeSelectedButtonView(title: "Sign Up")
        return button
    }()
    
    private lazy var loginButton = {
        let button = UIButton()
        button.changeSelectedButtonView(title: "Sign In")
        return button
    }()
    
    // MARK: Properties
    var handle: AuthStateDidChangeListenerHandle?
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        handle = Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                let tabBarController = TabBarController()
                tabBarController.selectedIndex = 1
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
//                self.enterEmail.text = nil
//                self.enterPassword.text = nil
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    private func setupView() {
        view.addSubview(enterEmail)
        enterEmail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterEmail.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            enterEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            enterEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(enterPassword)
        enterPassword.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterPassword.topAnchor.constraint(equalTo: enterEmail.bottomAnchor, constant: 8),
            enterPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            enterPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: enterPassword.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        loginButton.addTarget(self, action: #selector(loginDidTouch), for: .touchUpInside)
        
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        signUpButton.addTarget(self, action: #selector(signUpDidTouch), for: .touchUpInside)
        
        enterEmail.delegate = self
        enterPassword.delegate = self
    }
    
    // MARK: Actions
    @objc
    func loginDidTouch(_ sender: AnyObject) {
        guard
            let email = enterEmail.text,
            let password = enterPassword.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "Sign In Failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                let tabBarController = TabBarController()
                tabBarController.selectedIndex = 1
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
            }
        }
    }
    
    @objc
    func signUpDidTouch(_ sender: AnyObject) {
        guard
            let email = enterEmail.text,
            let password = enterPassword.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error == nil {
                Auth.auth().signIn(withEmail: email, password: password)
                let tabBarController = TabBarController()
                tabBarController.selectedIndex = 1
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
            } else {
                print("Error in createUser: \(error?.localizedDescription ?? "")")
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == enterEmail {
            enterPassword.becomeFirstResponder()
        }
        
        if textField == enterPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}

