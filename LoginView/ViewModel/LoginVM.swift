//
//  LoginVM.swift
//  LoginView
//
//  Created by LORIN VURAL on 15.09.2025.
//

import Foundation

class LoginVM {
    
    // MARK: - Properties
    private var isLoading = false {
        didSet {
            onLoadingStateChanged?(isLoading)
        }
    }
    
    // MARK: - Closures for binding
    var onErrorMessage: ((String) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onLoginSuccess: (() -> Void)?
    
    // MARK: - Public Methods
    func login(email: String, password: String) {
        // Prevent multiple login attempts
        guard !isLoading else { return }
        
        // Validate input
        guard let errorMessage = validateInput(email: email, password: password) else {
            performLogin(email: email, password: password)
            return
        }
        
        onErrorMessage?(errorMessage)
    }
    
    // MARK: - Private Methods
    private func validateInput(email: String, password: String) -> String? {
        // Check if email is empty
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Email veya kullanıcı adı gereklidir"
        }
        
        // Check if password is empty
        if password.isEmpty {
            return "Şifre gereklidir"
        }
        
        // Check minimum character length
        if email.trimmingCharacters(in: .whitespacesAndNewlines).count < 3 {
            return "En az 3 karakter girilmeli"
        }
        
        if password.count < 3 {
            return "Şifre en az 3 karakter olmalıdır"
        }
        
        // Validate email format if it contains @ (email format check)
        if email.contains("@") && !isValidEmail(email) {
            return "Geçerli bir email adresi giriniz"
        }
        
        return nil
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func performLogin(email: String, password: String) {
        isLoading = true
        
        // Simulate API call
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) { [weak self] in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                // Simulate login logic
                if self?.mockLoginCheck(email: email, password: password) == true {
                    self?.onLoginSuccess?()
                } else {
                    self?.onErrorMessage?("Email veya şifre hatalı")
                }
            }
        }
    }
    
    private func mockLoginCheck(email: String, password: String) -> Bool {
        // Mock login - you can replace this with actual API call
        // For demo purposes, accept any email with password "123456"
        return password == "123456" || (email.lowercased() == "test@test.com" && password == "test")
    }
}

// MARK: - Validation Extensions
extension LoginVM {
    
    /// Validates if the given string is a valid email format
    /// - Parameter email: Email string to validate
    /// - Returns: Boolean indicating if email is valid
    func validateEmailFormat(_ email: String) -> Bool {
        return isValidEmail(email)
    }
    
    /// Validates if the password meets minimum requirements
    /// - Parameter password: Password string to validate
    /// - Returns: Boolean indicating if password is valid
    func validatePasswordRequirements(_ password: String) -> Bool {
        return password.count >= 3
    }
    
    /// Validates if the input is not empty and meets minimum character requirement
    /// - Parameter input: String to validate
    /// - Returns: Boolean indicating if input is valid
    func validateMinimumLength(_ input: String) -> Bool {
        return input.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
    }
}
