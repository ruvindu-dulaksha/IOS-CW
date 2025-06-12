//
//  AreaPresenter.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-11.
//

import Foundation
import SwiftUI


import SwiftUI

class CrowdViewModel: ObservableObject {
    @Published var areas: [Area] = [
        Area(name: "Library", peopleCount: 1),
        Area(name: "Study Area", peopleCount: 4),
        Area(name: "Cafeteria", peopleCount: 6)
    ]
    
    func increasePeople(in area: Area) {
        if let index = areas.firstIndex(where: { $0.id == area.id }) {
            areas[index].peopleCount = min(6, areas[index].peopleCount + 1)
        }
    }
    
    func decreasePeople(in area: Area) {
        if let index = areas.firstIndex(where: { $0.id == area.id }) {
            areas[index].peopleCount = max(0, areas[index].peopleCount - 1)
        }
    }
}
