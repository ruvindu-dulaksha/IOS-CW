//
//  ForgetPasswordPresenter.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//
import Foundation
import SwiftUI

class ForgetPasswordPresenter: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var navigateToResetPassword: Bool = false
    @Published var showOTPModal: Bool = false
    @Published var enteredOTP: String = ""

    let expectedOTP = "123456" 
    private let allowedEmailTypes = ["student.nibm.lk", "lecturer.nibm.lk"]

    func submit() {
        errorMessage = nil

        guard !email.isEmpty else {
            errorMessage = "Please enter your email."
            return
        }

        guard isEmailValid(email) else {
            errorMessage = "Invalid email type."
            return
        }

        guard let _ = UserStorage.shared.users.first(where: { $0.email == email }) else {
            errorMessage = "Email not found. Please create an account first."
            return
        }

        
        print("Simulated OTP Sent: \(expectedOTP) to \(email)")
        showOTPModal = true
    }

    func isEmailValid(_ email: String) -> Bool {
        guard let domain = email.split(separator: "@").last else { return false }
        return allowedEmailTypes.contains(String(domain))
    }

    func verifyOTP() {
        if enteredOTP == expectedOTP {
            showOTPModal = false
            navigateToResetPassword = true
        } else {
            errorMessage = "Incorrect OTP. Please try again."
        }
    }

    func resetOTP() {
        enteredOTP = ""
        errorMessage = nil
    }
}
