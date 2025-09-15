//
//  LoginVC.swift
//  LoginView
//
//  Created by LORIN VURAL on 15.09.2025.
//
//
//  LoginVC.swift
//  LoginView
//
//  Created by LORIN VURAL on 15.09.2025.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var userIconImageView: UIImageView!
    @IBOutlet private weak var lockIconImageView: UIImageView!
    @IBOutlet private weak var passwordToggleButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var orContinueWithLabel: UILabel!
    @IBOutlet private weak var googleButton: UIButton!
    @IBOutlet private weak var appleButton: UIButton!
    @IBOutlet private weak var facebookButton: UIButton!
    @IBOutlet private weak var createAccountLabel: UILabel!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    private var viewModel = LoginVM()
    private var isPasswordVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupTextFields()
    }
    
    private func setupUI() {
        welcomeLabel.text = LoginTexts.welcomeTitle
        emailTextField.placeholder = LoginTexts.emptyPlaceholder
        passwordTextField.placeholder = LoginTexts.emptyPlaceholder
        passwordTextField.isSecureTextEntry = true
        passwordToggleButton.setImage(UIImage(systemName: LoginImages.eyeClosed), for: .normal)
        forgotPasswordButton.setTitle(LoginTexts.forgotPasswordTitle, for: .normal)
        loginButton.setTitle(LoginTexts.loginButtonTitle, for: .normal)
        orContinueWithLabel.text = LoginTexts.orContinueWith
        setupSocialButtons()
        createAccountLabel.text = LoginTexts.createAccountText
        errorMessageLabel.text = LoginTexts.emptyPlaceholder
        errorMessageLabel.textColor = .systemPink
        userIconImageView.image = UIImage(systemName: LoginImages.person)
        lockIconImageView.image = UIImage(systemName: LoginImages.lock)
        
    }
    
    private func setupSocialButtons() {
        googleButton.setImage(UIImage(named: LoginImages.google), for: .normal)
        facebookButton.setImage(UIImage(named: LoginImages.facebook), for: .normal)
        appleButton.setImage(UIImage(systemName: LoginImages.appleLogo), for: .normal)
    }
    
    private func setupTextFields() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupBindings() {
            viewModel.onErrorMessage = { [weak self] message in
                DispatchQueue.main.async {
                    self?.showErrorMessage(message)
                }
            }
            viewModel.onLoadingStateChanged = { [weak self] isLoading in
                DispatchQueue.main.async {
                    if isLoading {
                        self?.loginButton.isEnabled = false
                    } else {
                        self?.textFieldDidChange()
                    }
                }
            }
            viewModel.onValidationStateChanged = { [weak self] isValid, errorMessage in
                DispatchQueue.main.async {
                    self?.loginButton.isEnabled = isValid
                    
                    if let errorMessage = errorMessage {
                        self?.showErrorMessage(errorMessage)
                    } else {
                        self?.hideErrorMessage()
                    }
                }
            }
        }
    
    @IBAction func passwordToggleButtonTapped(_ sender: UIButton) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        
        let imageName = isPasswordVisible ? LoginImages.eyeOpen : LoginImages.eyeClosed
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        hideErrorMessage()
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        viewModel.login(email: email, password: password)
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        return
    }
    
    @IBAction func googleButtonTapped(_ sender: UIButton) {
        return
    }
    
    @IBAction func appleButtonTapped(_ sender: UIButton) {
        return
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        return
    }
    
    @objc private func textFieldDidChange() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        viewModel.validateForm(email: email, password: password)
    }
    
    private func showErrorMessage(_ message: String) {
            errorMessageLabel.text = message
            errorMessageLabel.isHidden = false
        }
        private func hideErrorMessage() {
            errorMessageLabel.isHidden = true
            errorMessageLabel.text = ""
        }
}
