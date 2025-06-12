//
//  InfoPresenter.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-13.
//

import Foundation

class InfoPresenter: ObservableObject {
    @Published var infoItems: [InfoItem] = [
        InfoItem(title: "Upcoming Events:", message: "Don't miss tonight’s theater performance 'Romeo & Juliet' at 7 PM in the Main Auditorium. Tickets still available!", emoji: "🎭"),
        InfoItem(title: "Campus Activities:", message: "Basketball game tonight! Cheer for the Eagles vs. State University at 6 PM in the Sports Complex.", emoji: "🏀")
    ]
}
