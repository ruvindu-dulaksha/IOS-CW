//
//  OnboardingPresenter.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-05.
//

import Foundation
import SwiftUI

final class OnboardingPresenter: ObservableObject {
    @Published var state: OnboardingState = .loading
    @Published var destination: OnboardingDestination? = nil
    let model: OnboardingModel
    
    init(model: OnboardingModel = .defaultOnboardingModel) {
        self.model = model
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.state = .ready
        }
    }
    
    func getStartedTapped() {
        withAnimation {
            destination = .login
            state = .navigating
        }
    }
    
}
