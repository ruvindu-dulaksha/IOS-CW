//
//  PrimaryButtonView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-06.
//

import SwiftUI

struct PrimaryButtonView: View {
    let buttonText: String
    let action: () -> Void
   
    
    
    var body: some View {
        
        Button(action: action){
            Text(buttonText)
                .fontWeight(.semibold)
                .frame(width: 300, height: 20)
                .padding()
                .background(Color.mainBlue)
                .foregroundColor(.white)
                .cornerRadius(13)
        }
        
        
    }
}

