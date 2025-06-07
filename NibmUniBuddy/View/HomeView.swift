//
//  HomeView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homePresenter = HomePresenter()
    
    var body: some View {
        NavigationView {
               VStack(spacing: 0) {
                   
                   HStack {
                       Button(action: {}) {
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
                       
                       Button(action: {}) {
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
                                    ScheduleItemView(item: scheduleItem) {
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
        }
        .onAppear {
           
        }
    }
}

#Preview {
    HomeView()
}
