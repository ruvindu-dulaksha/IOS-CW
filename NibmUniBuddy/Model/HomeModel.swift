//
//  HomeModel.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import Foundation

struct TodayScheduleItem: Identifiable {
    let id = UUID()
    let time: String
    let title: String
    let location: String
    let icon: String
    let isLive: Bool
}

struct AnnouncementItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
}

struct EventItem: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let description: String
    let icon: String
}

class HomeDataStorage {
    static let shared = HomeDataStorage()
    
    private init() {}
    
    func getTodaySchedule() -> [TodayScheduleItem] {
        return [
            TodayScheduleItem(time: "10:00 AM", title: "Mobile Development", location: "Lecture Hall 2", icon: "graduationcap.fill", isLive: false),
            TodayScheduleItem(time: "Live", title: "Cafeteria", location: "Room A102", icon: "person.3.fill", isLive: true),
            TodayScheduleItem(time: "3:00 PM – 5:00 PM", title: "Reservation", location: "Library", icon: "bookmark.fill", isLive: false),
            TodayScheduleItem(time: "6:00 PM", title: "Study Group", location: "Room B205", icon: "person.2.fill", isLive: false)
        ]
    }
    
    func getAnnouncements() -> [AnnouncementItem] {
        return [
            AnnouncementItem(title: "Announcement", description: "Don't miss the upcoming career fair next week!", icon: "graduationcap.fill")
        ]
    }
    
    func getUpcomingEvents() -> [EventItem] {
        return [
            EventItem(title: "Career Fair 2025", date: "April 30", description: "Meet with top employers and explore career opportunities", icon: "briefcase.fill"),
            EventItem(title: "Tech Workshop", date: "May 5", description: "Learn about latest mobile development trends", icon: "laptopcomputer"),
            EventItem(title: "Sports Day", date: "May 10", description: "Annual inter-departmental sports competition", icon: "sportscourt.fill"),
            EventItem(title: "Cultural Festival", date: "May 15", description: "Celebrate diversity with music, dance and food", icon: "music.note")
        ]
    }
}
