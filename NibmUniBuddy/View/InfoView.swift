//
//  InfoView.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-13.
//

import SwiftUI

struct InfoView: View {
    @ObservedObject var presenter = InfoPresenter()
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                   
                    headerView
                    
                    
                    infoCardsSection
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
    
    
    private var headerView: some View {
        VStack(spacing: 20) {
            
            HStack {
              
                
               
                
               
            }
            
                        HStack {
                (
                    Text("NIBM ")
                        .foregroundColor(Color("MainBlueColor")) +
                    Text("UNI BUDDY")
                        .foregroundColor(.red)
                )
                .font(.system(size: 28, weight: .bold, design: .rounded))
            }
        }
        .padding(.horizontal, 4)
    }
    
    
    private var infoCardsSection: some View {
        LazyVStack(spacing: 12) {
            ForEach(presenter.infoItems) { item in
                InfoCardView(item: item)
            }
        }
    }
}


struct InfoCardView: View {
    let item: InfoItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(item.title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            
            
            HStack(alignment: .top, spacing: 8) {
                Text(item.emoji)
                    .font(.system(size: 20))
                
                Text(item.message)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                
                Spacer()
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 0.5)
        )
    }
}


struct InfoItem: Identifiable {
    let id = UUID()
    let title: String
    let emoji: String
    let message: String
}

class InfoPresenter: ObservableObject {
    @Published var infoItems: [InfoItem] = [
        InfoItem(title: "Academic Calendar", emoji: "📅", message: "Stay updated with important academic dates, exam schedules, and semester timelines."),
        InfoItem(title: "Library Services", emoji: "📚", message: "Access digital resources, book reservations, and study room bookings."),
        InfoItem(title: "Student Support", emoji: "🎓", message: "Get help with academic guidance, counseling services, and career development."),
        InfoItem(title: "Campus Facilities", emoji: "🏫", message: "Explore dining options, recreational facilities, and campus transportation."),
        InfoItem(title: "Announcements", emoji: "📢", message: "Important updates from the administration and academic departments.")
    ]
}

#Preview {
    InfoView()
}
