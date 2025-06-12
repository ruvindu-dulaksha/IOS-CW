//
//  AreaRowView.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-11.
//

import SwiftUI

struct CrowdLevelRow: View {
    var area: Area
    @ObservedObject var viewModel: CrowdViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(area.name)
                    .font(.headline)
                Text("- \(area.status.rawValue)")
                    .font(.subheadline)
                    .foregroundColor(Color("subGreycolor"))
            }
            HStack(spacing: 30) {
                ForEach(0..<6) { index in
                    Image(systemName: "person.fill")
                        .foregroundColor(index < area.peopleCount ? area.status.color : .gray)
                        .onTapGesture {
                            if index < area.peopleCount {
                                viewModel.decreasePeople(in: area)
                            } else {
                                viewModel.increasePeople(in: area)
                            }
                        }
                }

                Capsule()
                    .frame(width: 10, height: 50)
                    .foregroundColor(area.status.color)
                    .padding(.leading, 4)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
    }
}

