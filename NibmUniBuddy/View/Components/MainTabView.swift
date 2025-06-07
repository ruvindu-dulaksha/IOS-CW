//
//  MainTabView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
          
            CrowdLevelView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Crowd Level")
                }
                .tag(0)
            
            
            MapView()
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("Map")
                }
                .tag(1)
            
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(2)
            
           
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar.badge.clock")
                    Text("Schedule")
                }
                .tag(3)
            
            
            ResourcesView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Resources")
                }
                .tag(4)
        }
        .accentColor(.mainBlue)
    }
}


struct CrowdLevelView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Crowd Level")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .navigationTitle("Crowd Level")
        }
    }
}

struct MapView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Map")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .navigationTitle("Map")
        }
    }
}

struct ScheduleView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Schedule")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .navigationTitle("Schedule")
        }
    }
}

struct ResourcesView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Resources")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .navigationTitle("Resources")
        }
    }
}

#Preview {
    MainTabView()
}
