//
//  InfoView.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-13.
//
import SwiftUI

struct InfoView: View {
    @ObservedObject var presenter = InfoPresenter()
    
    var body: some View {
        VStack(spacing: 10) {

            HStack (spacing: 30){
                Image(systemName: "bell")
                    .foregroundColor(.black)
                
                Spacer()
                
                (
                    Text("NIBM ")
                        .foregroundColor(Color("MainBlueColor")) +
                    Text("UNI BUDDY")
                        .foregroundColor(Color.red.opacity(3.0))
                )
                .font(.system(size: 22, weight: .bold))

                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            .padding()
            

            HStack {
                Button(action: {
    
                }) {
                    Text("< Back")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // Cards
            VStack(alignment: .leading, spacing: 16) {
                ForEach(presenter.infoItems) { item in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text("\(item.emoji) \(item.message)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
            .padding()
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview{
    InfoView()
}
