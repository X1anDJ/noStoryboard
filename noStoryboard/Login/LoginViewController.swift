//
//  ViewController.swift
//  noStoryboard
//
//  Created by Dajun Xian on 2023/10/2.
//

import UIKit

class LoginViewController: UIViewController {
    
    let appTitle = UILabel()
    let appDescription = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessage = UILabel()
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension LoginViewController {
    private func style() {
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        appTitle.text = "Dajun's Home"
        appTitle.textAlignment = .center
        appTitle.textColor = .black
        appTitle.font = .preferredFont(forTextStyle: .title1)
        
        appDescription.translatesAutoresizingMaskIntoConstraints = false
        appDescription.text = "Welcome to my home!"
        appDescription.textAlignment = .center
        appDescription.textColor = .black
        appDescription.font = .preferredFont(forTextStyle: .headline)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8  //for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.textAlignment = .center
        errorMessage.numberOfLines = 0
        errorMessage.text = "Error failure"
        errorMessage.isHidden = true
        errorMessage.textColor = .systemRed
        
    }
    private func layout() {
        view.addSubview(appTitle)
        view.addSubview(appDescription)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessage)
        
        NSLayoutConstraint.activate([
            appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appDescription.topAnchor.constraint(equalToSystemSpacingBelow: appTitle.bottomAnchor, multiplier: 2),
            appTitle.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appTitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            appDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescription.bottomAnchor, multiplier: 2),
            appDescription.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appDescription.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessage.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessage.leadingAnchor.constraint(equalToSystemSpacingAfter: loginView.leadingAnchor, multiplier: 1),
            errorMessage.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
    }
}

extension LoginViewController {
    @objc func signInTapped() {
        errorMessage.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password can't be blank")
        }
        
        if username == "Dajun" && password == "'" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    func configureView(withMessage message: String) {
        errorMessage.isHidden = false
        errorMessage.text = message
    }
}
