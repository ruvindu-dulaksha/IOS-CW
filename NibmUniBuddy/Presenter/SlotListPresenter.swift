//
//  ParkingPresenter.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-09.
//

import Foundation
import Combine

class SlotListPresenter: ObservableObject {
    @Published var slots: [ParkingSlot] = []

    init() {
        loadSlots()
    }

    func loadSlots() {
        slots = (1...10).map { ParkingSlot(id: "A-\($0)") }
    }
}
