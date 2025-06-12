//
//  InfoItem.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-13.
//

import Foundation

struct InfoItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let emoji: String
}
