//
//  Area.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-11.
//

import SwiftUI

enum CrowdStatus: String {
    case empty = "Empty"
    case moderate = "Moderate"
    case busy = "Busy"
    
    var color: Color {
        switch self {
        case .empty: return .blue
        case .moderate: return .orange
        case .busy: return .red
        }
    }
}

struct Area: Identifiable {
    let id = UUID()
    var name: String
    var peopleCount: Int
    
    var status: CrowdStatus {
        switch peopleCount {
        case 0...2: return .empty
        case 3...4: return .moderate
        default: return .busy
        }
    }
}
