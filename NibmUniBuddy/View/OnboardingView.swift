//
//  OnboardingView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-05.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var presenter = OnboardingPresenter()
    var body: some View {
        ZStack{
            if presenter.state == .ready {
                onboardingContent
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            } else {
                Color.white
                    .ignoresSafeArea()
            }
        }
        .fullScreenCover(item: $presenter.destination){destination in
            switch destination{
            case .login:
                LoginView()
            case .main:
                EmptyView()
            }
        }
    }
    private var onboardingContent: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text(presenter.model.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.mainBlue)
                .padding(.top, 20)
            
            Image(presenter.model.imageName) // Replace with your actual asset name
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            
            Text(presenter.model.subtitle)
                .font(.headline)
                .foregroundColor(.mainBlue)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
            
            Spacer()
            Text(presenter.model.description)
                .font(.subheadline)
                .foregroundColor(.subGreycolor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
                .padding(.top, 5)
                
            
            Button(action: presenter.getStartedTapped) {
                Text(presenter.model.buttonTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.mainBlue)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 40)
        }
    }
}


#Preview {
    OnboardingView()
}
