//
//  OnboardingModel.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-05.
//

import Foundation
import SwiftUI

struct OnboardingModel {
    let title: String
    let subtitle: String
    let description: String
    let buttonTitle: String
    let imageName: String
    
    
    static let defaultOnboardingModel = OnboardingModel(
        title: "Welcome to",
        subtitle: "Your Smart Guide to Campus Life!",
        description: "Let us help you find your way! discover everything around campus, in real time.",
        buttonTitle: "Get Started",
        imageName: "logo"
    )
    
    
    
}


enum OnboardingState {
    case loading
    case ready
    case navigating
    
}

enum OnboardingDestination: Identifiable {
    case login
    case main

    var id: String {
        switch self {
        case .login: return "login"
        case .main: return "main"
        }
    }
}
