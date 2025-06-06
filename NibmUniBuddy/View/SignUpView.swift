//
//  SignUpView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-06.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject private var signUpPresenter = SignUpPresenter()
    
    @State private var showTitle = false
    @State private var showImage = false
    @State private var showFields = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 30)

            if showTitle {
                Text("Sign Up")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.mainBlue)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }

            if showImage {
                Image("loginImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .transition(.scale.combined(with: .opacity))
            }

            if showFields {
                VStack(spacing: 16) {
                    Group {
                        TextField("Full Name", text: $signUpPresenter.fullName)
                        TextField("NIBM ID", text: $signUpPresenter.nibmId)
                        TextField("NIBM Email", text: $signUpPresenter.email)
                            .keyboardType(.emailAddress)
                        SecureField("Password", text: $signUpPresenter.password)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.systemGray6), lineWidth: 1))
                }
                .padding(.horizontal, 24)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            if showFields {
                PrimaryButtonView(buttonText: "Sign Up") {
                    signUpPresenter.signUp()
                }
                .padding(.horizontal, 24)
                .transition(.scale.combined(with: .opacity))
            }

            if let error = signUpPresenter.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .transition(.opacity)
            }

            if showFields {
                Text("By signing up, you agree to the university’s [Terms of Use] and [Privacy Policy].")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    .fixedSize(horizontal: false, vertical: true)  // << add this


                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Button("Log In") {
                        dismiss()
                    }
                    .foregroundColor(.mainBlue)
                    .font(.footnote)
                    .transition(.opacity)
                }
                .padding(.bottom, 16)
                .transition(.opacity)
            }

            Spacer()
        }
        .alert("Success", isPresented: $signUpPresenter.isSignedUp) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You have signed up successfully.")
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) { showTitle = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeOut(duration: 0.6)) { showImage = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeOut(duration: 0.6)) { showFields = true }
            }
        }
        .padding(.top, 16)
        .background(Color(.systemBackground).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
}
