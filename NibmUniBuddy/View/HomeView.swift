//
//  HomeView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homePresenter = HomePresenter()
    @State private var showingInfo = false
    @State private var showingResources = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    Button(action: {
                        showingInfo = true 
                    }) {
                        Image(systemName: "bell")
                            .font(.system(size: 25, weight: .medium))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("NIBM")
                         .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.mainBlue)

                        Text("UNI BUDDY")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                    
                    Spacer()
                    
                    
                    Button(action: {
                        NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 30, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .background(Color(.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.separator))
                        .offset(y: 0),
                    alignment: .bottom
                )
            
                ScrollView {
                    VStack(spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Hey, \(homePresenter.userName) 👋")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                    
                                    Text("\(homePresenter.currentDate) • \(homePresenter.currentTime)")
                                        .font(.subheadline)
                                        .foregroundColor(.subGreycolor)
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                      
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Quick Access")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            Button(action: {
                                showingResources = true
                            }) {
                                HStack(spacing: 16) {
                                    Image(systemName: "book.closed.fill")
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
                                        Text("Academic Resources")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)
                                        
                                        Text("Access study materials, contact info, and more")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
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
                            .padding(.horizontal, 20)
                        }
                        
                       
                        if !homePresenter.announcements.isEmpty {
                            VStack(spacing: 16) {
                                ForEach(homePresenter.announcements, id: \.id) { announcement in
                                    AnnouncementCardView(announcement: announcement) {
                                        homePresenter.onAnnouncementTapped(announcement)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                      
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Coming Up Events")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(homePresenter.upcomingEvents, id: \.id) { event in
                                        EventCardView(event: event) {
                                            homePresenter.onEventItemTapped(event)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        
                      
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Today's Schedule")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            VStack(spacing: 16) {
                                ForEach(homePresenter.todaySchedule, id: \.id) { scheduleItem in
                                    TodayScheduleItemView(item: scheduleItem) {
                                        homePresenter.onScheduleItemTapped(scheduleItem)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        
                        Color.clear.frame(height: 100)
                    }
                }
                .background(Color(.systemBackground))
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingInfo) {
                InfoView()
            }
            .sheet(isPresented: $showingResources) {
                ResourceView()
            }
        }
        .sheet(isPresented: $homePresenter.navigateToFullSchedule) {
            FullScheduleView()
        }
        .onAppear {
           
        }
    }
}


struct FullScheduleView: View {
    @StateObject private var presenter = ScheduleViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach($presenter.scheduleItems) { item in
                            ScheduleCard(item: item)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 100)
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            }
            .navigationTitle("Full Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.mainBlue)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
