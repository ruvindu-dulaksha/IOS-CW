//
//  SIgnUpPresenter.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-06.
//

import Foundation

class SignUpPresenter: ObservableObject {
    @Published var fullName: String = ""
    @Published var nibmId: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var errorMessage: String?
    @Published var isSignedUp: Bool = false
    
    private let allowedEmailTypes = ["student.nibm.lk", "lecturer.nibm.lk"]
    
    func signUp() {
        errorMessage = nil
        
        guard !fullName.isEmpty,
              !nibmId.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        guard isEmailValid(email) else {
            errorMessage = "Invalid NIBM email."
            return
        }
        
        let newUser = UserModel(email: email, password: password)
        UserStorage.shared.addUser(newUser)
        isSignedUp = true
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        guard let emailType = email.split(separator: "@").last else {
            return false
        }
        return allowedEmailTypes.contains(String(emailType))
    }
}
