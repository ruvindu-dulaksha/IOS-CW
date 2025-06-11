//
//  HomeModel.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//


import Foundation

struct ScheduleItem {
    let id: String
    let time: String
    let title: String
    let location: String
    let icon: String
    let isLive: Bool
}

struct AnnouncementItem {
    let id: String
    let title: String
    let description: String
    let icon: String
}

struct EventItem {
    let id: String
    let title: String
    let date: String
    let description: String
    let icon: String
}

class HomeDataStorage {
    static let shared = HomeDataStorage()
    
    private init() {}
    
    func getTodaySchedule() -> [ScheduleItem] {
        return [
            ScheduleItem(id: "1", time: "10:00 AM", title: "Mobile Development", location: "Lecture Hall 2", icon: "graduationcap.fill", isLive: false),
            ScheduleItem(id: "2", time: "Live", title: "Cafeteria", location: "Room A102", icon: "person.3.fill", isLive: true),
            ScheduleItem(id: "3", time: "3:00 PM – 5:00 PM", title: "Reservation", location: "Library", icon: "bookmark.fill", isLive: false),
            ScheduleItem(id: "4", time: "6:00 PM", title: "Study Group", location: "Room B205", icon: "person.2.fill", isLive: false)
        ]
    }
    
    func getAnnouncements() -> [AnnouncementItem] {
        return [
            AnnouncementItem(id: "1", title: "Announcement", description: "Don't miss the upcoming career fair next week!", icon: "graduationcap.fill")
        ]
    }
    
    func getUpcomingEvents() -> [EventItem] {
        return [
            EventItem(id: "1", title: "Career Fair 2025", date: "April 30", description: "Meet with top employers and explore career opportunities", icon: "briefcase.fill"),
            EventItem(id: "2", title: "Tech Workshop", date: "May 5", description: "Learn about latest mobile development trends", icon: "laptopcomputer"),
            EventItem(id: "3", title: "Sports Day", date: "May 10", description: "Annual inter-departmental sports competition", icon: "sportscourt.fill"),
            EventItem(id: "4", title: "Cultural Festival", date: "May 15", description: "Celebrate diversity with music, dance and food", icon: "music.note")
        ]
    }
}
