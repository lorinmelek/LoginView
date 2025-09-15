//
//  LoginVC.swift
//  LoginView
//
//  Created by LORIN VURAL on 15.09.2025.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - IBOutlets
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
    
    // MARK: - Properties
    private var viewModel = LoginVM()
    private var isPasswordVisible = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupTextFields()
        
        
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        // Welcome label
        welcomeLabel.text = "Welcome Back!"
        welcomeLabel.textAlignment = .left
        
        // Text fields placeholder
        emailTextField.placeholder = ""
        passwordTextField.placeholder = ""
        passwordTextField.isSecureTextEntry = true
        
        // Password toggle button
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        
        // Forgot password button
        forgotPasswordButton.setTitle("Forgot Password", for: .normal)
       
        // Login button
        loginButton.setTitle("Login", for: .normal)
        
        // Or continue with label
        orContinueWithLabel.text = "- Or Continue With -"
                
        // Social media buttons setup
        setupSocialButtons()
        
        // Create account label
        createAccountLabel.text = "Create an account. Sign up"
        
        // Error message label
        errorMessageLabel.text = ""
        errorMessageLabel.textColor = .systemPink
        
        // Icons setup
        userIconImageView.image = UIImage(systemName: "person")
        lockIconImageView.image = UIImage(systemName: "lock")
    }
    
    private func setupSocialButtons() {
        // Google button
        googleButton.setImage(UIImage(named: "google"), for: .normal)
        // Apple button
        appleButton.setImage(UIImage(systemName: "applelogo"), for: .normal)
        appleButton.tintColor = .label
        // Facebook button
        facebookButton.setImage(UIImage(named: "facebook"), for: .normal)
    }
    
    private func setupTextFields() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupBindings() {
        // Error message binding
        viewModel.onErrorMessage = { [weak self] message in
            DispatchQueue.main.async {
                self?.showErrorMessage(message)
            }
        }
        
        // Loading state binding
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.updateLoadingState(isLoading)
            }
        }
        
        // Login success binding
        viewModel.onLoginSuccess = { [weak self] in
            DispatchQueue.main.async {
                // Navigate to main screen
                self?.handleLoginSuccess()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func passwordToggleButtonTapped(_ sender: UIButton) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        hideErrorMessage()
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        viewModel.login(email: email, password: password)
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        print("Forgot password tapped")
    }
    
    @IBAction func googleButtonTapped(_ sender: UIButton) {
        print("Google login tapped")
    }
    
    @IBAction func appleButtonTapped(_ sender: UIButton) {
        print("Apple login tapped")
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        print("Facebook login tapped")
    }
    
    @objc private func textFieldDidChange() {
        hideErrorMessage()
    }
    
    // MARK: - Helper Methods
    private func showErrorMessage(_ message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
    
    private func hideErrorMessage() {
        errorMessageLabel.isHidden = true
        errorMessageLabel.text = ""
    }
    
    private func updateLoadingState(_ isLoading: Bool) {
        loginButton.isEnabled = !isLoading
        
        if isLoading {
            loginButton.setTitle("", for: .normal)
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.color = .white
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x: loginButton.bounds.width/2, y: loginButton.bounds.height/2)
            loginButton.addSubview(activityIndicator)
            loginButton.tag = 999 // To identify and remove later
        } else {
            loginButton.setTitle("Login", for: .normal)
            if let activityIndicator = loginButton.viewWithTag(999) {
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    private func handleLoginSuccess() {
        // Navigate to main screen or show success message
        let alert = UIAlertController(title: "Başarılı", message: "Giriş başarıyla tamamlandı!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            loginButtonTapped(loginButton)
        }
        return true
    }
}
