//
//  ScheduleRowView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import SwiftUI

struct ScheduleItemView: View {
    let item: ScheduleItem
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                Image(systemName: item.icon)
                    .font(.title2)
                    .foregroundColor(.mainBlue)
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        if item.isLive {
                            Text("Live")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.red)
                        } else {
                            Text(item.time)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                    }
                    
                    Text(item.title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(item.location)
                        .font(.caption)
                        .foregroundColor(.subGreycolor)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
