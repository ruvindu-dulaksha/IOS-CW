//
//  SplashView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-04.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @StateObject private var splashController = SplashController()
    
    
    var body: some View {
        ZStack() {
            
            if splashController.isFinishedLoading {
                OnboardingView()
                    .transition(.opacity.animation(.easeInOut(duration: 0.6)))
            } else {
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    Image(splashController.logoImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                    LottieView(filename: splashController.lottieAnimation)
                        .frame(width: 80, height: 80)
                        .padding(.top, 30)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: splashController.isFinishedLoading)
        .onAppear {
            splashController.onAppear()
        }
    }
    
    }


#Preview {
    SplashView()
}
