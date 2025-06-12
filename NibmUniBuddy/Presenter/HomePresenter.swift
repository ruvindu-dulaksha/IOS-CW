//
//  HomePresenter.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import Foundation
import Combine

class HomePresenter: ObservableObject {
    @Published var currentDate: String = ""
    @Published var currentTime: String = ""
    @Published var userName: String = ""
    @Published var greeting: String = ""
    @Published var todaySchedule: [ScheduleItem] = []
    @Published var announcements: [AnnouncementItem] = []
    @Published var upcomingEvents: [EventItem] = []
    
    private var timer: AnyCancellable?
    
    init() {
        loadData()
        startTimer()
    }
    
    deinit {
        timer?.cancel()
    }
    
    private func loadData() {
       
        todaySchedule = HomeDataStorage.shared.getTodaySchedule()
        announcements = HomeDataStorage.shared.getAnnouncements()
        upcomingEvents = HomeDataStorage.shared.getUpcomingEvents()
        
       
        setUserName()
        
        
        updateDateTime()
    }
    
    private func setUserName() {
       
        let currentEmail = getCurrentUserEmail()
        if let emailPrefix = currentEmail.split(separator: "@").first {
            userName = String(emailPrefix).capitalized
        } else {
            userName = "User"
        }
        
        updateGreeting()
    }
    
    private func getCurrentUserEmail() -> String {

        return UserDefaults.standard.string(forKey: "loggedInUserEmail") ?? "user@student.nibm.lk"
    }
    
    private func updateGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:
            greeting = "Good Morning"
        case 12..<17:
            greeting = "Good Afternoon"
        default:
            greeting = "Good Evening"
        }
    }
    
    private func updateDateTime() {
        let now = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        currentDate = dateFormatter.string(from: now)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm"
        currentTime = timeFormatter.string(from: now)
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateDateTime()
                self?.updateGreeting()
            }
    }
    
    func onScheduleItemTapped(_ item: ScheduleItem) {
        
        print("Schedule item tapped: \(item.title)")
    }
    
    func onEventItemTapped(_ item: EventItem) {
       
        print("Event item tapped: \(item.title)")
    }
    
    func onAnnouncementTapped(_ item: AnnouncementItem) {
        
        print("Announcement tapped: \(item.title)")
    }
}
