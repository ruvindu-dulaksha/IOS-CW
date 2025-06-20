//
//  LoginView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-05.
//

import SwiftUI

struct LoginView: View {
    @State private var navigateToSignUp = false
    @State private var navigateToForgetPassword = false
    @State private var navigateToHome = false

    @StateObject private var loginPresenter = LoginPresenter()
    
    @State private var showFields = false
    @State private var showImage = false
    @State private var showTitle = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer(minLength: 30)

                if showTitle {
                    Text("Login")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.mainBlue)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }

                if showImage {
                    Image("loginImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                        .transition(.scale.combined(with: .opacity))
                        .padding(.top, 10)
                }

                if showFields {
                    VStack(spacing: 16) {
                        TextField("Enter your NIBM Email", text: $loginPresenter.email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)

                        SecureField("Password", text: $loginPresenter.password)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                }
                
                HStack{
                    Spacer()
                    Button("Forget Password?"){
                        navigateToForgetPassword = true
                    }
                    .font(.footnote)
                    .foregroundColor(.subGreycolor)
                    .padding(.horizontal)
                    .padding(.trailing)
                }
                .navigationDestination(isPresented: $navigateToForgetPassword) {
                    ForgetPasswordView()
                        .navigationBarBackButtonHidden(true)
                }

                if showFields {
                    PrimaryButtonView(buttonText: "Login") {
                        loginPresenter.login()
                    }
                    .padding(.horizontal, 24)
                }

                if let error = loginPresenter.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }

                if showFields {
                    HStack {
                        Text("Don't have an account?")
                            .font(.footnote)
                            .foregroundColor(.subGreycolor)
                        Button("Sign Up") {
                            navigateToSignUp = true
                        }
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundColor(.mainBlue)
                    }
                }

                Spacer()
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
            .onChange(of: loginPresenter.isAuthenticated) { oldValue, newValue in
                if newValue {
                    navigateToHome = true
                }
            }
            .padding()
            .background(Color(.systemBackground).ignoresSafeArea())
           
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUpView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $navigateToHome) {
                MainTabView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    LoginView()
}


