//
//  LoginVM.swift
//  LoginView
//
//  Created by LORIN VURAL on 15.09.2025.
//

import Foundation

class LoginVM {
    enum ValidationError: Error {
       case emailRequired
       case passwordRequired
       case emailTooShort
       case passwordTooShort
       case invalidEmailFormat
       
       var message: String {
           switch self {
           case .emailRequired:
               return "Required email or username"
           case .passwordRequired:
               return "Required password"
           case .emailTooShort:
               return "Username should be at least 3 character"
           case .passwordTooShort:
               return "Password should be at least 5 character"
           case .invalidEmailFormat:
               return "Enter valid email"
           }
       }
    }
    
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
        do {
            try validateLoginForm(email: email, password: password)
            isValid = true
        } catch let error as ValidationError {
            errorMessage = error.message
        } catch {
            errorMessage = "Unknown error occurred"
        }
    }
        
    private func validateLoginForm(email: String, password: String) throws {
            let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedEmail.isEmpty {
                if !email.isEmpty {
                    throw ValidationError.emailRequired
                }
            } else if trimmedEmail.count < 3 {
                throw ValidationError.emailTooShort
            } else if password.isEmpty {
                if !email.isEmpty {
                    throw ValidationError.passwordRequired
                }
            } else if password.count < 5 {
                throw ValidationError.passwordTooShort
            } else if email.contains("@") && !isValidEmail(email) {
                throw ValidationError.invalidEmailFormat
            }
        }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

