//
//  ForgetPasswordView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import SwiftUI

struct ForgetPasswordView: View {
    @StateObject private var forgetpasswordPresenter = ForgetPasswordPresenter()
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
                        Text("back")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.top)

                Text("Forget Password")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.mainBlue)

                Image("forgetpassword")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)

                Text("No worries! Enter your student email address and we'll send you a OTP to reset your password.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                TextField("NIBM Email", text: $forgetpasswordPresenter.email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                if let error = forgetpasswordPresenter.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                PrimaryButtonView(buttonText: "Submit") {
                    forgetpasswordPresenter.submit()
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .sheet(isPresented: $forgetpasswordPresenter.showOTPModal, onDismiss: {
                forgetpasswordPresenter.resetOTP()
            }) {
                OTPModalView(presenter: forgetpasswordPresenter)
            }
            .navigationDestination(isPresented: $forgetpasswordPresenter.navigateToResetPassword) {
                ResetPasswordView(email: forgetpasswordPresenter.email)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}



#Preview {
    ForgetPasswordView()
}
