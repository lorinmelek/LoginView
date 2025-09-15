//
//  LoginVM.swift
//  LoginView
//
//  Created by LORIN VURAL on 15.09.2025.
//

import Foundation

class LoginVM {
    
    private var isLoading = false {
        didSet {
            onLoadingStateChanged?(isLoading)
        }
    }
    
    var onErrorMessage: ((String) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onLoginSuccess: (() -> Void)?
    
    var onValidationStateChanged: ((Bool, String?) -> Void)?
    func login(email: String, password: String) {
        guard !isLoading else { return }
        
        var errorMessage: String? = nil
        var isValid = false
        validateFormInternal(email: email, password: password, isValid: &isValid, errorMessage: &errorMessage)
        
        if isValid {
            isLoading = true
        } else if let errorMessage = errorMessage {
            onErrorMessage?(errorMessage)
        }
    }
    
    func validateForm(email: String, password: String) {
        var errorMessage: String? = nil
        var isValid = false
        validateFormInternal(email: email, password: password, isValid: &isValid, errorMessage: &errorMessage)
        onValidationStateChanged?(isValid, errorMessage)
    }
    
    private func validateFormInternal(email: String, password: String, isValid: inout Bool, errorMessage: inout String?) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedEmail.isEmpty {
            if !email.isEmpty {
                errorMessage = "Required email or username"
            }
        } else if trimmedEmail.count < 3 {
            errorMessage = "Username should be at least 3 character"
        } else if password.isEmpty {
            if !email.isEmpty {
                errorMessage = "Required password"
            }
        } else if password.count < 5 {
            errorMessage = "Password should be at least 5 character"
        } else if email.contains("@") && !isValidEmail(email) {
            errorMessage = "Enter valid email"
        } else {
            isValid = true
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

