//
//  OTPEntryView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import SwiftUI

struct OTPModalView: View {
    @ObservedObject var presenter: ForgetPasswordPresenter

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter OTP")
                .font(.title2)
                .bold()
                .padding(.top)

            Text("Please enter the 6-digit code sent to your email.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            TextField("Enter OTP", text: $presenter.enteredOTP)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            if let error = presenter.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button(action: {
                presenter.verifyOTP()
            }) {
                Text("Verify")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.mainBlue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}
