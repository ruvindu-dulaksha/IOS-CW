//
//  SplashController.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-04.
//

import SwiftUI
import Combine


final class SplashPresenter: ObservableObject {
    @Published var isFinishedLoading: Bool = false
    private let model = SplashModel()
    
    var logoImageName : String {
        return model.logoImageName
    }
    var lottieAnimation : String {
        return model.lottieAnimation
    }
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                   self.isFinishedLoading = true
        }
    }
}

