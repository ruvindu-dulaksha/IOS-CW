//
//  SplashView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-04.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @StateObject private var splashPresenter = SplashPresenter()
    
    
    var body: some View {
        ZStack() {
            
            if splashPresenter.isFinishedLoading {
                OnboardingView()
                    .transition(.opacity.animation(.easeInOut(duration: 0.6)))
            } else {
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    Image(splashPresenter.logoImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                    LottieView(filename: splashPresenter.lottieAnimation)
                        .frame(width: 80, height: 80)
                        .padding(.top, 30)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: splashPresenter.isFinishedLoading)
        .onAppear {
            splashPresenter.onAppear()
        }
    }
    
    }


#Preview {
    SplashView()
}
