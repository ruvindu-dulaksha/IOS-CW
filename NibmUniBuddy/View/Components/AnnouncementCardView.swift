//
//  AnnouncementCardView.swift
//  NibmUniBuddy
//
//  Updated with bottom sheet functionality and Academic Resources button styling
//
import Foundation
import SwiftUI

struct AnnouncementCardView: View {
    let announcement: AnnouncementItem
    let onTap: () -> Void
    @State private var showingBottomSheet = false
    
    var body: some View {
        Button(action: {
            showingBottomSheet = true
        }) {
            HStack(spacing: 16) {
               
                Image(systemName: announcement.icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.mainBlue, .blue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                    )
                
              
                VStack(alignment: .leading, spacing: 4) {
                    Text(announcement.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(announcement.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                
                Spacer()
                
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.mainBlue)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingBottomSheet) {
            AnnouncementDetailBottomSheet(announcement: announcement)
        }
    }
}

struct AnnouncementDetailBottomSheet: View {
    let announcement: AnnouncementItem
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(10)
                        .contentShape(Rectangle())
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Divider()
                .padding(.bottom, 12)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Image("announcementImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.85)
                        .cornerRadius(18)
                        .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 6)
                        .padding(.horizontal)
                    
                    
                    Text(announcement.title)
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                
                    Text(announcement.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                }
                .padding(.bottom, 50)
            }
        }
        .background(
           
            ZStack {
                Color(UIColor.systemBackground)
                VisualEffectBlur(blurStyle: .systemMaterial)
            }
            .ignoresSafeArea()
        )
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .cornerRadius(28, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.15), radius: 25, x: 0, y: -10)
        .padding(.top, 10)
    }
}

fileprivate extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

fileprivate struct RoundedCorner: Shape {
    var radius: CGFloat = 0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
