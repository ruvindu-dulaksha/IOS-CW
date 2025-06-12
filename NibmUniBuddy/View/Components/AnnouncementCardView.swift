//
//  AnnouncementCardView.swift
//  NibmUniBuddy
//
//  Updated with bottom sheet functionality
//

import SwiftUI

struct AnnouncementCardView: View {
    let announcement: AnnouncementItem
    let onTap: () -> Void
    @State private var showingBottomSheet = false
    
    var body: some View {
        Button(action: {
            showingBottomSheet = true
        }) {
            HStack(spacing: 12) {
                // Icon
                Image(systemName: announcement.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color.accentColor)
                    )
                
                // Content
                VStack(alignment: .leading, spacing: 2) {
                    Text(announcement.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(announcement.description)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Arrow
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.subGreycolor)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
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
            // Top bar with dismiss button (like a sheet header)
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
                    // Announcement Image
                    Image("announcementImage") // Replace with real image name or dynamic source
                        .resizable()
                        .aspectRatio(contentMode: .fit) // fit instead of fill, no clipping
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.85)
                        .cornerRadius(18)
                        .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 6)
                        .padding(.horizontal)
                    
                    // Title
                    Text(announcement.title)
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    // Description (allow multiline, scrollable if too long)
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
            // Add a smooth background with material + solid color fallback
            ZStack {
                Color(UIColor.systemBackground)
                VisualEffectBlur(blurStyle: .systemMaterial) // Optional custom blur view
            }
            .ignoresSafeArea()
        )
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .cornerRadius(28, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.15), radius: 25, x: 0, y: -10)
        .padding(.top, 10) // push sheet content down a bit for better visual balance
    }
}

// Helper extension to round specific corners
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

// Optional: VisualEffectBlur wrapper for UIKit UIBlurEffect if you want nicer blur background
// You can remove this and just keep Color(UIColor.systemBackground) if you want simpler code.
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

