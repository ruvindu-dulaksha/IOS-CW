//
//  CrowdDetailView.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-12.
//
import SwiftUI

struct CrowdDetailView: View {
    @ObservedObject var viewModel: CrowdViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Crowd Details")
                .font(.system(size: 22, weight: .bold))                .foregroundColor(Color("MainBlueColor"))

            ForEach(viewModel.areas) { area in
                CrowdLevelRow(area: area, viewModel: viewModel)
            }

            Spacer()
        }
        .padding()
    }
}
