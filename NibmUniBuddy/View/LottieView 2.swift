//
//  LottieView.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-10.


import SwiftUI
import Lottie

struct LottieView2: UIViewRepresentable {
    var filename: String

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = .scaleAspectFit
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

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

