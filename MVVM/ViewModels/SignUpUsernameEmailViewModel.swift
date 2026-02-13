


import Foundation
import SwiftUI
import Combine


class SignUpUsernameEmailViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var email = ""
    @Published var password = ""
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var showNextPage = false
    @Published var confirmPassword = ""
    @Published var showWelcomePage = false
    
    
    func validate () {
        
        guard validateEmail() && validateUsername() else { return }
        
        showNextPage = true
    }
    
    func validatePassword () {
        if !password.isEmpty && !confirmPassword.isEmpty {
            guard confirmedPassWord() else { return }
        } else {
            alertTitle = "Password Empty!"
            alertMessage = "Please put some password on the field."
            showAlert = true
        }
    }
    
    
    private func confirmedPassWord() -> Bool {
        if password == confirmPassword {
            alertTitle = "Success!"
            alertMessage = "Please check your email for the activation link."
            showAlert = true
        } else {
            alertTitle = "Password Mismatch!"
            alertMessage = "Please check passwords."
            password = ""
            confirmPassword = ""
            showAlert = true
            return false
        }
        return true
    }
    
    
    private func validateUsername() -> Bool {
        guard !username.isEmpty else {
            alertTitle = "Username Required"
            alertMessage = "Please provide a username"
            showAlert = true
            return false
        }
        return true
    }
    
    private func validateEmail () -> Bool {
        guard !email.isEmpty else {
            alertTitle = "Email Required"
            alertMessage = "Please provide a email"
            showAlert = true
            return false
        }
        return true
    }
    
  
}
