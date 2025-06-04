//
//  LottieView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-04.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let filename: String
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: filename)
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        
        return view
        
            
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}









