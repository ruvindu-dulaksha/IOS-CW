//
//  ResetPasswordView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//


import SwiftUI

struct ResetPasswordView: View {
    let email: String
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var isPasswordReset: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.black)
                        Text("Back")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.top)

                Text("Reset Password")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.mainBlue)

                Text("Please create a new password for your NIBM UNI BUDDY account.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                SecureField("Password", text: $newPassword)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                SecureField("Confirm New Password", text: $confirmPassword)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                PrimaryButtonView(buttonText: "Reset Password") {
                    resetPassword()
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isPasswordReset) {
                LoginView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }

    private func resetPassword() {
        guard !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        guard newPassword == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        if UserStorage.shared.updatePassword(for: email, to: newPassword) {
            isPasswordReset = true
        } else {
            errorMessage = "User not found."
        }

    }
}


#Preview {
    ResetPasswordView(email: "preview@student.nibm.lk")
}


