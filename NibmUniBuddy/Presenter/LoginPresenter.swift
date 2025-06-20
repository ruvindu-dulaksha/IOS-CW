//
//  LoginPresenter.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-06.
//

import Foundation

class LoginPresenter : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var errorMessage : String?
    @Published var isAuthenticated: Bool = false
    
    private let allowedEmailTypes = ["student.nibm.lk", "lecturer.nibm.lk"]
    
    func login() {
        errorMessage = nil
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        guard isEmailValid(email) else {
            errorMessage = "Invalid email Type."
            return
        }
        
        guard UserStorage.shared.validateUser(email: email, password: password) else {
            errorMessage = "Invalid email or password."
            return
        }

        
        UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
        
       
        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        guard let emailType = email.split(separator:"@").last else {
            return false
        }
        return allowedEmailTypes.contains(String(emailType))
    }
}
