//
//  CrowdLevelView.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-11.
//


import SwiftUI

struct CrowdLevelView: View {
    @StateObject private var viewModel = CrowdViewModel()
    @State private var showDetail = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Crowd Level Indicator")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color("MainBlueColor"))
                    

                ForEach(viewModel.areas) { area in
                    CrowdLevelRow(area: area, viewModel: viewModel)
                }

                Spacer()

                VStack(spacing: 5) {
                    Divider()
                    Text("Only available for\nmoderators")
                        .font(.system(size: 14))
                        .foregroundColor(Color("subGreycolor"))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        showDetail = true
                    }) {
                        Text("Moderator")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color("MainBlueColor"))
                            .cornerRadius(10)
                            .padding(.horizontal, 60)
                    }
                }

                NavigationLink(destination: CrowdDetailView(viewModel: viewModel), isActive: $showDetail) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

#Preview{
    CrowdLevelView()
}

